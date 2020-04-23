/*
21. Find out the maximum PC price for each maker having models in the PC table. 
Result set: maker, maximum price.
*/
SELECT maker, MAX(pc.price)
FROM product
	RIGHT JOIN pc ON product.model = pc.model
GROUP BY maker

/*
22. For each value of PC speed that exceeds 600 MHz, find out the average price of PCs 
with identical speeds. Result set: speed, average price.
*/
SELECT speed, AVG(price) AS avg_price
FROM pc
WHERE speed > 600
GROUP BY speed

/*
23. Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with 
a speed of 750 MHz or higher. Result set: maker
*/
SELECT DISTINCT product.maker
FROM product
	RIGHT JOIN pc ON product.model = pc.model
WHERE speed >= 750
INTERSECT
SELECT DISTINCT product.maker
FROM product
	RIGHT JOIN laptop ON product.model = laptop.model
WHERE speed >= 750

/*
24. List the models of any type having the highest price of all products present in the database.
*/
SELECT model
FROM pc
WHERE price >= ALL (
	SELECT MAX(price)
	FROM pc
	UNION
	SELECT MAX(price)
	FROM laptop
	UNION
	SELECT MAX(price)
	FROM printer
)
UNION
SELECT model
FROM laptop
WHERE price >= ALL (
	SELECT MAX(price)
	FROM pc
	UNION
	SELECT MAX(price)
	FROM laptop
	UNION
	SELECT MAX(price)
	FROM printer
)
UNION
SELECT model
FROM printer
WHERE price >= ALL (
	SELECT MAX(price)
	FROM pc
	UNION
	SELECT MAX(price)
	FROM laptop
	UNION
	SELECT MAX(price)
	FROM printer
)

/*
25. Find the printer makers also producing PCs with the lowest RAM capacity and the highest 
processor speed of all PCs having the lowest RAM capacity. Result set: maker.
*/
SELECT maker
FROM product
WHERE type = 'printer'
INTERSECT
SELECT maker
FROM product
WHERE model IN (
	SELECT model
	FROM pc
	WHERE ram = (--lowest RAM capacity
			SELECT MIN(ram)
			FROM pc
		)
		AND speed = (--highest processor speed,lowest RAM capacity
			SELECT MAX(speed)
			FROM pc
			WHERE ram = (
				SELECT MIN(ram)
				FROM pc
			)
		)
)

/*
26. Find out the average price of PCs and laptops produced by maker A.
Result set: one overall average price for all items.

refer->WITH CTE(common table expression)
https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15
*/
WITH prices (price) AS (
		SELECT pc.price AS price
		FROM pc
			LEFT JOIN product ON product.model = pc.model
		WHERE product.maker = 'A'
		UNION ALL
		SELECT laptop.price AS price
		FROM laptop
			LEFT JOIN product ON product.model = laptop.model
		WHERE product.maker = 'A'
	)
SELECT AVG(price) AS AVG_price
FROM prices

/*
27. Find out the average hard disk drive capacity of PCs produced by makers who also 
manufacture printers. Result set: maker, average HDD capacity.
*/
SELECT product.maker, AVG(pc.hd)
FROM product
	RIGHT JOIN pc ON product.model = pc.model
WHERE product.maker IN (
	SELECT maker
	FROM product
	WHERE type = 'printer'
)
GROUP BY product.maker

/*
28. Using Product table, find out the number of makers who produce only one model.
*/
WITH makers AS (
		SELECT maker AS Qty_model
		FROM Product
		GROUP BY maker
		HAVING COUNT(model) = 1
	)
SELECT COUNT(*)
FROM makers

/*
29. Under the assumption that receipts of money (inc) and payouts (out) are registered not more 
than once a day for each collection point [i.e. the primary key consists of (point, date)], write 
a query displaying cash flow data (point, date, income, expense).Use Income_o and Outcome_o tables.
*/
SELECT CASE 
		WHEN income_o.point IS NULL THEN outcome_o.point
		ELSE income_o.point
	END
	, CASE 
		WHEN income_o.date IS NULL THEN outcome_o.date
		ELSE income_o.date
	END, income_o.inc, outcome_o.out
FROM income_o
	FULL JOIN outcome_o
	ON income_o.point = outcome_o.point
		AND income_o.date = outcome_o.date

/*
30. Under the assumption that receipts of money (inc) and payouts (out) can be registered any number
of times a day for each collection point [i.e. the code column is the primary key], display a table 
with one corresponding row for each operating date of each collection point.
Result set: point, date, total payout per day (out), total money intake per day (inc).Missing values 
are considered to be NULL.
*/
-- 先求出有收入支出的日期，在汇总每个日期下的收支
WITH keys(point,date) as(
    SELECT DISTINCT point,
        date
    FROM income
    UNION
    SELECT DISTINCT point,
        date
    FROM outcome 
)SELECT point,date,
    (SELECT sum(out)
    FROM outcome
    WHERE outcome.point=k.point
            AND outcome.date=k.date) AS outcome, 
    (SELECT sum(inc)
    FROM income
    WHERE income.point=k.point
            AND income.date=k.date) AS income
FROM keys AS k

-- 另外一种解法，分别求收入和支出，最后从输入支出临时表中求合计
SELECT point, date, SUM(out), SUM(inc)
FROM(
    SELECT point, date, null AS out, SUM(inc) AS inc
    FROM Income
    GROUP BY point, date
    UNION 
    SELECT point, date, SUM(out) AS out, NULL AS inc
    FROM Outcome
    GROUP BY point, date) AS asd
GROUP BY point, date





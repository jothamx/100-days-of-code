/*
31. For ship classes with a gun caliber of 16 in. or more, display the class and the country.
*/
SELECT class, country
FROM classes
WHERE bore >= 16

/*
32. One of the characteristics of a ship is one-half the cube of the calibre of its main guns (mw).
Determine the average ship mw with an accuracy of two decimal places for each country having ships 
in the database.
*/
SELECT country
	, CONVERT(NUMERIC(6, 2), AVG(power(bore, 3) * 0.5))
FROM (
	SELECT country, bore, name
	FROM Classes, Ships
	WHERE Classes.class = Ships.class
	UNION
	SELECT country, bore, ship
	FROM Classes, Outcomes
	WHERE Classes.class = Outcomes.ship
) AS new_ships
GROUP BY country

/*
33. Get the ships sunk in the North Atlantic battle. Result set: ship.
*/
SELECT ship
FROM outcomes
WHERE result = 'sunk'
	AND battle = 'North Atlantic'

/*
34. In accordance with the Washington Naval Treaty concluded in the beginning of 1922, it was prohibited 
to build battle ships with a displacement of more than 35 thousand tons.
Get the ships violating this treaty (only consider ships for which the year of launch is known).
List the names of the ships.
*/
SELECT DISTINCT name
FROM classes, ships
WHERE classes.class = ships.class
	AND launched >= 1922
	AND displacement > 35000
	AND type = 'bb'

/*
35. Find models in the Product table consisting either of digits only or Latin letters (A-Z, case 
insensitive) only. Result set: model, type.
*/
SELECT model, type
FROM Product
WHERE model LIKE replicate('[0-9]', len(model))
	OR model LIKE replicate('[a-zA-Z]', len(model))

/*
36. List the names of lead ships in the database (including the Outcomes table).
*/
SELECT class
FROM classes
WHERE class IN (
	SELECT name
	FROM ships
	UNION
	SELECT ship
	FROM outcomes
)

/*
37. Find classes for which only one ship exists in the database (including the Outcomes table).
*/
SELECT class
FROM (
	SELECT class, name
	FROM ships
	UNION
	SELECT c.class, o.ship
	FROM classes c INNER JOIN outcomes o
	ON c.class = o.ship
) allships
GROUP BY allships.class
HAVING COUNT(allships.name) = 1

/*
38. Find countries that ever had classes of both battleships (‘bb’) and cruisers (‘bc’).
*/

SELECT country
FROM classes
WHERE type = 'bb'
INTERSECT
SELECT country
FROM classes
WHERE type = 'bc'

/*
39. Find the ships that `survived for future battles`; that is, after being damaged in a 
battle, they participated in another one, which occurred later.
*/
WITH t1 AS (
		SELECT ship, date
		FROM outcomes, battles
		WHERE outcomes.battle = battles.name
			AND outcomes.result = 'damaged'
	), 
	t2 AS (
		SELECT ship, date
		FROM outcomes, battles
		WHERE outcomes.battle = battles.name
	)
SELECT DISTINCT t2.ship
FROM t1 INNER JOIN t2
ON t1.ship = t2.ship
WHERE t1.date < t2.date

/*
40.Get the makers who produce only one product type and more than one model. Output: maker, type.
*/
SELECT DISTINCT maker, type
FROM product
WHERE maker IN (
	SELECT maker
	FROM product
	GROUP BY maker
	HAVING COUNT(DISTINCT type) = 1
	AND COUNT(DISTINCT model) > 1
)
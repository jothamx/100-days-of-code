/*
41. For each maker who has models at least in one of the tables PC, Laptop, or Printer, determine 
the maximum price for his products.Output: maker; if there are NULL values among the prices for 
the products of a given maker, display NULL for this maker, otherwise, the maximum price.
*/
SELECT pro.maker
-- COALESCE(pri.price, 922337203685477) 当遇到NULL返回1个可能的最大值
-- MAX(...)如果包含NULL就返回922337203685477，数据库里价格不太可能比这个值还大
-- NULLIF(expr1,expr2),erpr1等于expr2返回NULL，否则返回expr1
    , NULLIF(MAX(COALESCE(pri.price, 922337203685477)), 922337203685477) AS price
FROM product pro
	INNER JOIN (
		SELECT model, price
		FROM printer
		UNION ALL
		SELECT model, price
		FROM pc
		UNION ALL
		SELECT model, price
		FROM laptop
	) pri
	ON pri.model = pro.model
GROUP BY pro.maker

/*
42.Find the names of ships sunk at battles, along with the names of the corresponding battles.
*/
SELECT ship, battle
FROM outcomes
WHERE result = 'sunk'

/*
43. Get the battles that occurred in years when no ships were launched into water.
*/
SELECT name
FROM Battles
WHERE datepart(yyyy, date) NOT IN (
	SELECT launched
	FROM Ships
	WHERE launched IS NOT NULL
)

/*
44. Find all ship names beginning with the letter R.
*/
SELECT name
FROM (
	SELECT name
	FROM ships
	UNION
	SELECT ship
	FROM outcomes
) ship
WHERE ship.name LIKE 'R%'

/*
45. Find all ship names consisting of three or more words (e.g., King George V).Consider the words 
in ship names to be separated by single spaces, and the ship names to have no leading or trailing spaces.
*/
SELECT name
FROM (
	SELECT name
	FROM ships
	UNION
	SELECT ship
	FROM outcomes
) ship
WHERE ship.name LIKE '% % %'

/*
46. For each ship that participated in the Battle of Guadalcanal, get its name, displacement,
and the number of guns.
Hint: A ship engaged in this battle should be listed even if its class is not known.
*/
SELECT s.ship, c.displacement, c.numGuns
FROM (
    --ship里不存在的就是lead ship，作为class属性，这里使用coalesce实现
	SELECT o.ship, coalesce(s.class, o.ship) AS class
	FROM outcomes AS o
		LEFT JOIN ships s ON s.name = o.ship
	WHERE o.battle = 'Guadalcanal'
) AS s
	LEFT JOIN classes c ON c.class = s.class

/*
49. Find the names of the ships having a gun caliber of 16 inches (including ships in the Outcomes table).
*/
SELECT name
FROM (
	SELECT name, bore
	FROM ships AS s
		LEFT JOIN classes AS c ON s.class = c.class
	UNION
	SELECT o.ship AS name, c.bore
	FROM classes AS c
		RIGHT JOIN outcomes o ON o.ship = c.class
) AS a
WHERE a.bore = 16

/*
50. Find the battles in which Kongo-class ships from the Ships table were engaged.
*/
SELECT DISTINCT battle
FROM Outcomes AS o
	INNER JOIN Ships AS s ON o.ship = s.name
WHERE s.class = 'Kongo'
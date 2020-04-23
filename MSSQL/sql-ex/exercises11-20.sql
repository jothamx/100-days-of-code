

/*
11. Find out the average speed of PCs.
*/
SELECT AVG(speed)
FROM pc

/*
12. Find out the average speed of the laptops priced over $1000.
*/
SELECT AVG(speed)
FROM laptop
WHERE price > 1000

/*
13. Find out the average speed of the PCs produced by maker A.
*/
SELECT AVG(speed)
FROM pc
	LEFT JOIN product ON pc.model = product.model
WHERE maker = 'A'

/*
14. For the ships in the Ships table that have at least 10 guns, get the class, name, and country.
*/
SELECT ships.class, ships.name, classes.country
FROM ships
	LEFT JOIN classes ON ships.class = classes.class
WHERE classes.numGuns >= 10

/*
15. Get hard drive capacities that are identical for two or more PCs.  Result set: hd.
*/
SELECT hd
FROM pc
GROUP BY hd
HAVING COUNT(*) >= 2

/*
16. Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair 
should be displayed only once, i.e. (i, j) but not (j, i).
Result set: model with the bigger number, model with the smaller number, speed, and RAM.
*/
SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM PC a
	INNER JOIN PC b ON a.model > b.model
WHERE a.speed = b.speed
	AND a.ram = b.ram

/*
17. Get the laptop models that have a speed smaller than the speed of any PC.
Result set: type, model, speed.
*/
SELECT DISTINCT product.type, laptop.model, laptop.speed
FROM product
	RIGHT JOIN laptop ON product.model = laptop.model
WHERE product.type = 'Laptop'
	AND laptop.speed < ALL (
		SELECT speed
		FROM pc
	)

/*
18. Find the makers of the cheapest color printers. Result set: maker, price.
*/
SELECT DISTINCT product.maker, printer.price
FROM product
	LEFT JOIN printer ON product.model = printer.model
WHERE printer.color = 'y'
	AND price = (
		SELECT MIN(price)
		FROM printer
		WHERE printer.color = 'y'
	)

/*
19. For each maker having models in the Laptop table, find out the average screen size of the 
laptops he produces. Result set: maker, average screen size.
*/
SELECT product.maker, AVG(laptop.screen)
FROM product
	RIGHT JOIN laptop ON product.model = laptop.model
GROUP BY maker

/*
20. Find the makers producing at least three distinct models of PCs.Result set: maker, number of PC models.
*/
SELECT maker, COUNT(model) AS Count_model
FROM product
WHERE type = 'pc'
GROUP BY maker
HAVING COUNT(model) > 2
/*
1. Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
*/
SELECT model,speed,hd 
FROM PC 
WHERE price<500

/*
2. List all printer makers. Result set: maker.
*/
SELECT DISTINCT  p1.maker 
FROM Product p1
WHERE p1.type = 'printer'

/*
3. Find the model number, RAM and screen size of the laptops with prices over $1000.
*/
SELECT model,ram,screen 
FROM Laptop 
WHERE price>1000

/*
4. Find all records from the Printer table containing data about color printers.
*/
SELECT * 
FROM Printer 
WHERE color='y'

/*
5. Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x 
CD drive.
*/
SELECT model,speed,hd 
FROM PC 
WHERE price<600 and cd in ('12x','24x')

/*
6. For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such 
laptops. Result set: maker, speed.
*/
SELECT DISTINCT Product.maker ,Laptop.speed 
FROM Product RIGHT JOIN Laptop
ON product.model=laptop.model
WHERE hd>=10

/*
7. Get the models and prices for all commercially available products (of any type) produced by maker B.
*/
SELECT Product.model,Laptop.price 
FROM Product JOIN Laptop
ON product.model=laptop.model
WHERE Product.maker='B'
UNION
SELECT Product.model,PC.price 
FROM Product JOIN PC
ON product.model=PC.model
WHERE Product.maker='B'
UNION
SELECT Product.model,Printer.price 
FROM Product JOIN Printer
ON Product.model=Printer.model
WHERE Product.maker='B'

/*
8. Find the makers producing PCs but not laptops.
*/
SELECT maker 
FROM product 
WHERE type='PC'
EXCEPT
SELECT maker 
FROM product 
RIGHT OUTER JOIN laptop 
    ON product.model=laptop.model

/*
9. Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.
*/
SELECT DISTINCT maker
FROM product
	RIGHT JOIN PC ON product.model = pc.model
WHERE pc.speed >= 450

/*
10. Find the printer models having the highest price. Result set: model, price.
*/
SELECT model, price
FROM printer
WHERE price = (
	SELECT MAX(price)
	FROM printer
)
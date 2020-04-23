/*
4.1 A 先生在自己的计算机（电脑）上，使用 CREATE TABLE 语句创建出了一张空的 Product（商品）表，并执行了
如下的 SQL 语句向其中插入数据。 紧接着，B 先生使用其他的计算机连接上该数据库，执行了如下 SELECT语句。
这时 B 先生能得到怎样的查询结果呢？

答案：1行结果也取不出来，A先生未commit 事务
*/
-- A
BEGIN TRANSACTION;
 INSERT INTO Product VALUES ('0001', 'T恤衫', 
'衣服', 1000, 500, '2008-09-20');
 INSERT INTO Product VALUES ('0002', '打孔器', 
'办公用品', 500, 320, '2008-09-11');
 INSERT INTO Product VALUES ('0003', '运动T恤', 
'衣服', 4000, 2800, NULL);

--B 
SELECT * FROM Product;

/*
4.2 使用如下的 INSERT 语句复制这 3 行数据，应该就能够将表中的数据增加为 6 行。请说出该语句的执行结果。
*/
--违反了 PRIMARY KEY 约束,无法插入
INSERT INTO Product SELECT * FROM Product;

/*
以练习 4.2 中的 Product 表为基础，再创建另外一张包含利润列的新表ProductMargin（商品利润）。请写出向上述表中
插入如下数据的 SQL 语句，其中的利润可以简单地通过对 Product 表中的数据进行计算（销售单价 - 进货单价）得出。
*/
INSERT INTO ProductMargin(product_id,product_name,sale_price,purchase_price,margin)
    SELECT product_id, product_name, sale_price, purchase_price , sale_price-purchase_price
    FROM Product;

/*
对练习 4.3 中的 ProductMargin 表的数据进行如下更改。
1. 将运动 T 恤的销售单价从 4000 日元下调至 3000 日元。
2. 根据上述结果再次计算运动 T 恤的利润。
更改后的ProductMargin表如下所示。请写出能够实现该变更的SQL语句
*/
UPDATE ProductMargin 
SET sale_price = 3000 
WHERE product_name = '运动T恤';

UPDATE ProductMargin 
SET margin = sale_price - purchase_price 
WHERE product_name = '运动T恤';
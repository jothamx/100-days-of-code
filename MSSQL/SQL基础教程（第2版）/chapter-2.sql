/*
创建表，插入初始数据
*/

CREATE TABLE Product(
    product_id CHAR(4) NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_type VARCHAR(32) NOT NULL,
    sale_price INTEGER ,
    purchase_price INTEGER ,
    regist_date DATE
);

insert into  Product(product_id,product_name,product_type,sale_price,purchase_price,regist_date)
values
('0001','T恤衫',' 衣服 ',1000 ,500 ,'2009-09-20'),
('0002','打孔器', '办公用品', 500, 320, '2009-09-11'),
('0003', '运动T恤', '衣服', 4000, 2800,NULL),
('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20'),
('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15'),
('0006', '叉子' ,'厨房用具' ,500, NULL,'2009-09-20'),
('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28'),
('0008', '圆珠笔' ,'办公用品' ,100,  NULL,'2009-11-11');

/*
2.1
编写一条 SQL 语句，从 Product（商品）表中选取出“登记日期（ regist_
date）在 2009 年 4 月 28 日之后”的商品。查询结果要包含 product_
name 和 regist_date 两列。
*/
select * from product where regist_date>'2009-04-28'

/*
2.2 
请说出对 Product 表执行如下 3 条 SELECT 语句时的返回结果
返回结果均为空，判断需要用is null ，is not  null 
*/
 SELECT *  FROM Product WHERE purchase_price = NULL;
 SELECT *  FROM Product WHERE purchase_price <> NULL;
 SELECT *  FROM Product WHERE product_name > NULL;
/*
2.3
代码清单 2-22（2-2 节）中的 SELECT 语句能够从 Product 表中取出“销
售单价（ sale_price）比进货单价（ purchase_price）高出 500
日元以上”的商品。请写出两条可以得到相同结果的 SELECT 语句。执行
结果如下所示。
*/

SELECT product_name, sale_price, purchase_price
FROM product
where sale_price-purchase_price>=500;

SELECT product_name, sale_price, purchase_price
FROM product
where sale_price >= purchase_price+500;

/*
2.4
请写出一条 SELECT 语句，从 Product 表中选取出满足“销售单价打九
折之后利润高于 100 日元的办公用品和厨房用具”条件的记录。查询结果
要包括 product_name 列、 product_type 列以及销售单价打九折之
后的利润（别名设定为 profit）。
*/

select product_name, sale_price,sale_price*0.9 as discount_sale_price, purchase_price
from Product
where sale_price*0.9-purchase_price>=100;
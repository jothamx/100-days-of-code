/*
1. 请指出下述 SELECT 语句中所有的语法错误。
*/
SELECT product_id, SUM(product_name)
-- 本SELECT语句中存在错误。
FROM Product
GROUP BY product_type
WHERE regist_date > '2009-09-01';
*/
--使用了字符类型的列（product_name）作为 SUM 函数的参数
--WHERE 子句写在了 GROUP BY 子句之后
--SELECT 子句中存在 GROUP BY 子句中未指定的列（product_id）
SELECT product_type, count(product_name) AS count
FROM Product
WHERE regist_date > '2009-09-01'
GROUP BY product_type;

/*
2. 请编写一条 SELECT 语句，求出销售单价（ sale_price 列）合计值是进货单价（ purchase_price 列）
合计值 1.5 倍的商品种类。
*/
SELECT product_type, SUM(sale_price)AS 'sum', SUM(purchase_price) AS 'sum'
FROM Product
GROUP BY product_type
HAVING SUM(sale_price) > SUM(purchase_price) * 1.5;

/*
3. 此前我们曾经使用 SELECT 语句选取出了 Product（ 商品） 表中的全部记录。当时我们使用了 ORDER BY 子句来
指定排列顺序，但现在已经无法记起当时如何指定的了。请根据下列执行结果，思考 ORDER BY 子句的内容。
*/
SELECT *
FROM Product
ORDER BY regist_date DESC, sale_price;

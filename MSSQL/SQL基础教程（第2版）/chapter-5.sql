/*
5.1 创建视图ViewPractice5_1
条件 1： 销售单价大于等于 1000 日元。
条件 2： 登记日期是 2009 年 9 月 20 日。
条件 3： 包含商品名称、销售单价和登记日期三列。
*/
CREATE VIEW ViewPractice5_1(product_name,sale_price,regist_date)
AS
SELECT product_name,sale_price,regist_date 
FROM Product
WHERE sale_price>=1000 and regist_date='2009-09-20'

GO
SELECT * FROM ViewPractice5_1

/*
5.2 向习题 5.1 中创建的视图 ViewPractice5_1 中插入如下数据，会得到什么样的结果呢？
*/
--不能将值 NULL 插入列 'product_id'，表 'testSql.dbo.Product'；列不允许有 Null 值。INSERT 失败。
INSERT INTO ViewPractice5_1 VALUES ('刀子', 300, '2009-11-02');

/*
5.3 请根据如下结果编写 SELECT 语句，其中 sale_price_all 列为全部商品的平均销售单价。
*/
SELECT product_id,product_name,product_type,sale_price,(
	SELECT AVG(sale_price) 
	FROM Product) AS sale_price_all
FROM Product

/*
请根据习题 5.1 中的条件编写一条 SQL 语句，创建一幅包含如下数据的视图（名称为 AvgPriceByType）
*/
CREATE VIEW AvgPriceByType(product_id,product_name,product_type,sale_price,avg_sale_price)
AS
SELECT product_id,product_name,product_type,sale_price,(
	SELECT AVG(sale_price) 
	FROM Product AS P1 where P1.product_type=Product.product_type 
	GROUP BY product_type)AS avg_sale_price
FROM Product

GO
SELECT * FROM AvgPriceByType

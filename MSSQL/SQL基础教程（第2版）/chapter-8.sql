/*
8.1 请说出针对本章中使用的 Product（商品）表执行如下 SELECT 语句所能得到的结果。
*/
-- 最后一列显示按照product_id依次向后，截至当前的最大值
SELECT product_id, product_name, sale_price,
    MAX (sale_price) OVER (ORDER BY product_id) AS current_max_price
FROM Product;

/*
8.1 继续使用Product表，计算出按照登记日期（regist_date）升序进行排列的各日期的销售
单价（sale_price）的总额。排序是需要将登记日期为NULL 的“运动 T 恤”记录排在第 1 位（也
就是将其看作比其他日期都早）。
*/
-- SQL Server NULL值默认在最前面，不需要特殊处理
-- 也可以通过COALESCE(regist_date,CAST('0001-01-1' as DATE))将NULL转换成较早的日期“骗”过数据库
SELECT regist_date,product_type,sale_price,
	SUM(sale_price) OVER(ORDER BY regist_date)AS current_sum_price
FROM Product
ORDER BY regist_date
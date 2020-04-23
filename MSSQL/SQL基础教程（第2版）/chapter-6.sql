/*
6.1	 对本章中使用的 Product（商品）表执行如下 2 条 SELECT 语句，能够得到什么样的结果呢
*/
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000);

-- 查询结果为空，NOT IN 的参数中不能包含 NULL
SELECT product_name, purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);

/*
6.2 按照销售单价（ sale_price）对练习 6.1 中的 Product（商品）表中的商品进行如下分类。
    ● 低档商品：销售单价在1000日元以下（T恤衫、办公用品、叉子、擦菜
    板、 圆珠笔）
    ● 中档商品：销售单价在1001日元以上3000日元以下（菜刀）
    ● 高档商品：销售单价在3001日元以上（运动T恤、高压锅）
        请编写出统计上述商品种类中所包含的商品数量的 SELECT 语句，结果如下所示。
执行结果
    low_price | mid_price | high_price
    ----------+----------+----------
    5         | 1         | 2
*/
SELECT  
	SUM(CASE WHEN sale_price<=1000 
			THEN 1 ELSE 0 
		END) AS low_price,
	SUM(CASE WHEN sale_price between 1001 and 3000 
			THEN 1 ELSE 0 
		END) AS mid_price,
	SUM(CASE WHEN sale_price >=3001 
			THEN 1 ELSE 0 
		END) AS high_price 
FROM Product
/*
7.1 请说出下述 SELECT 语句的结果。
*/
-- 返回结果等同于SELECT * FROM Product
SELECT *
FROM Product
UNION
SELECT *
FROM Product
INTERSECT
SELECT *
FROM Product
ORDER BY product_id;

/*
 7-2 节的代码清单 7-11 中列举的外联结的结果中，高压锅和圆珠笔 2 条
记录的商店编号（ shop_id）和商店名称（ shop_name）都是 NULL。请使
用字符串“不确定”替换其中的 NULL。期望结果如下所示
*/
SELECT 
    -- 利用COALESCE函数替换NULL
    COALESCE(sp.shop_id,'不确定') as shop_id,
    COALESCE(sp.shop_name,'不确定') as shop_name,
    p.product_id,
    p.product_name,
    p.sale_price
FROM 
    ShopProduct AS sp 
        RIGHT OUTER JOIN Product AS p
        ON  sp.product_id=p.product_id;
-- 这里的排序使用的是结果的shop_id,使用sp.shop_id结果会不同
ORDER BY shop_id;
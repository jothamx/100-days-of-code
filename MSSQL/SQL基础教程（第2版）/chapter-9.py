# pymssql 文档地址如下
# https://pymssql.readthedocs.io/en/latest/index.html
import pymssql

# SQL config
SERVER="127.0.0.1"
USER="sa"
PASSWORD="123456"
DB="testSql"

conn=pymssql.connect(SERVER, USER, PASSWORD, DB)
cursor = conn.cursor()

# 清空Product数据
cursor.execute("DELETE FROM Product")

# 插入数据
cursor.executemany("INSERT INTO Product VALUES(%s,%s,%s,%d,%d,%s)",
   [('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20'),
    ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11'),
    ('0003', '运动T恤', '衣服', 4000, 2800, None),
    ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20'),
    ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15'),
    ('0006', '叉子', '厨房用具', 500, None, '2009-09-20'),
    ('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28'),
    ('0008', '圆珠笔', '办公用品', 100, None, '2009-11-11')
    ]
)
conn.commit()
# 读取数据
cursor.execute('SELECT * FROM Product')
row = cursor.fetchone()
while row:
    print(row)
    row = cursor.fetchone()

print("\n\n\n\n")

# 修改数据
cursor.execute("UPDATE Product SET product_name='Y恤衫' WHERE product_name='T恤衫';")
conn.commit()

# 再次读取数据
cursor.execute('SELECT * FROM Product')
row = cursor.fetchone()
while row:
    print(row)
    row = cursor.fetchone()

conn.close()

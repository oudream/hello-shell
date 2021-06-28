

### last row
```sql
SELECT * FROM TABLE WHERE ID = (SELECT MAX(ID) FROM TABLE);
```

### 分页
```sql
--- 查询第一行起的5行数据，可以有两种语句： 
select * from T_user limit 5 offset 0; 
-- or 
select * from  T_user limit 0,5;
```

### 解决数据删除后占用空间不变的问题
```sql
VACUUM
```

### 判断表
```sql
select * from sqlite_master
SELECT COUNT(*) AS COUNTER FROM `sqlite_master` WHERE `type`='table' AND `name`='YC_POINT_TABLE';
```

### 查询与判断列
```sql
PRAGMA  table_info([USER_LOGIN])
```
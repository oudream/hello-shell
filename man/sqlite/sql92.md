### HOWTO - SQL92 Syntax
- http://www.owen.sj.ca.us/~rk/howto/sql92.html

### Types:
```sql
	CHAR(n) | CHARACTER(n)
	VARCHAR(n) | CHARACTER VARYING(n) | <VARCHAR2(n)>
	INTEGER | INT | SMALLINT
	DECIMAL(p,s) | DEC(p,s) | NUMERIC(p,s)
	FLOAT(p) | REAL | DOUBLE PRECISION
	DATE | TIME
	INTERVAL year-month | INTERVAL day
	BOOLEAN | BLOB
```

### Conditionals:
```sql
	< > <= >= <> =			AND OR NOT
	IS [NOT] NULL			[NOT] LIKE
	[NOT] IN ( [,...] )		[NOT] BETWEEN x AND y
	[conditional] ANY ( [,...] )
	[conditional] ALL ( [,...] )
```

### Functions:
```sql
	AVG | MAX | MIN | SUM | COUNT
	GREATEST|LEAST(x,y,...)
	<{ROUND|TRUNC<!ATE>}({x,places|date,format})>
	POSITION( s1 IN s2)
	EXTRACT( datetime FROM datetime_value)
	CHAR_LENGTH( s1 ) <LENGTH( s1 )>
	SUBSTRING(string FROM start [FOR length])|<SUBSTR(string,start,length)>
	<INSTR(str,substr,start,mnth)>
	{<INITCAP>|UPPER|LOWER}(string)
	TRIM({BOTH|LEADING|TRAILING} char FROM string)|<{L|R}TRIM(str,chrset)>
	{TRANSLATE|CONVERT}( char USING value) |<TRANSLATE(str,from,to)>
	<{L|R}PAD(str,to_len,str2)>
	<DECODE(expr,search1,result1,...[,default])>
	<NVL(expr,replace)>
```

### <Date Format - ROUND|TRUNC|TO_CHAR|TO_DATE(value,fmt)>:
```sql
	SYYYY|YYYY|YEAR|SYEAR|YY|IYYY|RR|RRRR		MONTH|MON|MM|RM
	DDD|DD|J	DAY|DY|D	HH|HH12|HH24	MI	SS|SSSSS
	IW  AM|PM  BC Q WW(year week) W (month week)
```

### Table Constraints:
```sql
	[CONSTRAINT cname] {{UNIQUE|PRIMARY KEY}(col,...)|
	CHECK(condition)|FOREIGN KEY (col,...) REFERENCES table(col,...)}
```

### Column Constraints:
```sql
	[CONSTRAINT cname] {[NOT] NULL|UNIQUE|PRIMARY KEY|
	REFERENCES table(col,...) ON DELETE CASCADE|CHECK(condition)}
```

### Command: ALTER TABLE
> Description: Modifies table properties
```sql
	ALTER TABLE table [ * ]
	    ADD [<!COLUMN>] column type
	ALTER TABLE table [ * ]
	    DROP [ COLUMN ] column
	ALTER TABLE table [ * ]
	    MODIFY [<!COLUMN>] column { <!SET> DEFAULT value | DROP DEFAULT }
	ALTER TABLE table [ * ]
	    MODIFY [<!COLUMN>] column column_constraint
	ALTER TABLE table [ * ]
	    RENAME [<!COLUMN>] column TO newcolumn
	ALTER TABLE table
	    RENAME TO newtable
	ALTER TABLE table
	    ADD table_constraint
	ALTER TABLE table
	    {ENABLE|DISABLE} {NO}VALIDATE CONSTRAINT constraint
```

### Command: ALTER USER
> Description: Set a user password
```sql
	ALTER USER username IDENTIFIED BY passwd
```

### Command: CREATE TABLE
> Description: Creates a new table
```sql
	CREATE <![TEMPORARY|TEMP]> TABLE table (
	    column type
	    [ NULL | NOT NULL ] [ UNIQUE ] [ DEFAULT value ]
	    [column_constraint_clause | PRIMARY KEY } [ ... ] ]
	    [, ... ]
	    [, PRIMARY KEY ( column [, ...] ) ]
	    [, CHECK ( condition ) ]
	    [, table constraint ]
	    )
	<CREATE TABLE table AS select query>
```

### (not SQL92) Command: (CREATE <OR REPLACE> TRIGGER)	
> Description: Creates a new trigger
```sql
	CREATE TRIGGER name { BEFORE | AFTER |INSTEAD OF}
	    {DELETE| INSERT | UPDATE [OF (col,...)] [OR ...] }
	    ON {table|view} FOR EACH { ROW | STATEMENT }
	    [ WHEN (condition) ]
	    [<!EXECUTE PROCEDURE func ( arguments )>| pl/sql block]
```

### (not SQL92) Command: CREATE INDEX	
> Description: Constructs a secondary index
```sql
	CREATE [UNIQUE|<BITMAP>] INDEX index_name ON table
	    [<!USING acc_name>] ( column [ASC|DESC][,...]) [NOSORT|REVERSE]
	CREATE [ UNIQUE ] INDEX index_name ON table
	    [ USING acc_name ] ( func_name( column [, ... ]) [ ops_name ] )
```

### Command: (CREATE <OR REPLACE> VIEW)
> Description: Constructs a virtual table
```sql
	CREATE VIEW view AS select query
	ALTER VIEW view COMPILE
```

### (not SQL92) Command: CREATE SYNONYM	
> Description: Create an alias for an object
```sql
	CREATE SYNONYM synname FOR object
```

### (Oracle) Command: COMMENT	
> Description: Comment on objects and view in USER_{TAB|COL}_COMMENTS
```sql
	COMMENT ON TABLE table IS 'string'
	COMMENT ON COLUMN table.col IS 'string'
```

### (Oracle) Command: TRUNCATE TABLE	
> Description: Remove all table rows
```sql
	TRUNCATE TABLE table
```

### (Oracle) Command: RENAME TABLE	
> Description: Rename the object
```sql
	RENAME table TO newtable
```

### Command: DROP
> Description: Removes existing objects from database
```sql
	DROP TABLE name [,...] <CASCADE CONSTRAINTS>
	DROP VIEW name
	DROP SEQUENCE name [,...]
	...
```

### Command: INSERT
> Description: Inserts new rows into a table
```sql

	INSERT INTO table [ ( column [, ...] ) ]
	    { VALUES ( expression [, ...] ) | SELECT query }

```

### Command: UPDATE
> Description: Replaces values of columns in a table
```sql
	UPDATE table SET col = expression [,...]
	    [ FROM fromlist ]
	    [ WHERE condition ]
```

### Command: DELETE
> Description: Removes rows from a table
```sql
	DELETE FROM table [ WHERE condition ]
```

### Command: SELECT query
> Description: Retrieve rows from a table or view
```sql
	SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
	    expression [ <![AS]> name ] [,...]
	    [ INTO [ TEMPORARY | TEMP ] [ TABLE ] new_table ]
	    [ FROM {table | (select query)} [ alias ] [,...] ]
	    [ {{LEFT | RIGHT} [OUTER] | NATURAL |[FULL] OUTER} JOIN table alias
		{ON condition | USING(col1,col2,...)} ]
	    [ WHERE {condition | EXISTS (correlated subquery)} ]
	    [ GROUP BY column [,...] ]
	    [ HAVING condition [,...] ]
	    [ { UNION [ ALL ] | INTERSECT | EXCEPT | MINUS } select ]
	    [ ORDER BY {column | int} [ ASC | DESC | USING operator ] [,...] ]
	    [ FOR UPDATE [ OF class_name [,...] ] ]
	    LIMIT { count | ALL } [ { OFFSET | ,} start ]
```

### (Oracle) Command: DECLARE	
> Description: Defines a cursor for table access
```sql
	DECLARE cursorname [ BINARY ] [ INSENSITIVE ] [ SCROLL ]
	    CURSOR FOR query
	    [ FOR { READ ONLY | UPDATE [ OF column [,...] ] ]
```

### (Oracle) Command: FETCH	
> Description: Gets rows using a cursor
```sql
	FETCH [ selector ] [ count ] { IN | FROM } cursor
	FETCH [ RELATIVE ] [{ [ # | ALL | NEXT | PRIOR ] }] FROM cursor
```

### (Oracle) Command: CLOSE	
> Description: Close a cursor
```sql
	CLOSE cursor
```

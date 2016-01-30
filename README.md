# Generating  inserts  by using  queries in Oracle

Using select to  generate  inserts can be useful  when you have to  fill up  some tables with  data that is complicated to get.

The simple way  is  to generate     the same numbers of insert as  you need. This can be slow, therefore  in order to  get a  faster way  you can use    <b>union </b> to  concatenate  the inserts into one single insert 
```sql

INSERT INTO table1
    
SELECT
    1,
    1,
    TIMESTAMP'2015-07-07 00:00:00.0' ,
    NULL ,
    'text'
FROM
    dual
    
union all    

SELECT
    2,
    2,
    TIMESTAMP'2015-07-07 00:00:00.0' ,
    NULL ,
    'text2'
FROM
    dual
```

With this kind of insert and  using   hierarchical Queries, it's easy  to get  a  one insert  with all  the values.

```sql
SELECT
    'Insert into main_table '||SUBSTR(tt.concat1, 11, LENGTH(tt.concat1))||' ; ' AS  "insert  main table",
    'Insert into child_table'||SUBSTR(tt.concat2, 11, LENGTH(tt.concat2))||' ; ' AS  "insert  child table"
FROM
    (
        SELECT
            sys_connect_by_path(to_clob(col), ' union all ')  AS concat1,
            sys_connect_by_path(to_clob(col2), ' union all ') AS concat2
        FROM
            (
                SELECT
                    'select ' || rownum ||' , '|| ''''||name ||''''||' , 1 from dual ' AS col,
                    'select ' || rownum ||' , '|| price ||' from dual '                AS col2,
                    rownum                                                             AS seq,
                    MAX(rownum) over (partition BY 1)                                  AS max_seq
                FROM
                    (
                        SELECT
                            'A' AS name,
                            2   AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'B' AS name,
                            3   AS price
                        FROM
                            dual
                         ) )
        WHERE
            seq = max_seq START WITH seq = 1 CONNECT BY prior seq+1 = seq ) tt
```



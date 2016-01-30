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
                        /* data or table  */
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
                        UNION
                        SELECT
                            'C' AS name,
                            5   AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'D' AS name,
                            9   AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'E' AS name,
                            15  AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'E' AS name,
                            25  AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'E' AS name,
                            35  AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'E' AS name,
                            45  AS price
                        FROM
                            dual
                        UNION
                        SELECT
                            'E' AS name,
                            5   AS price
                        FROM
                            dual ) )
        WHERE
            seq = max_seq START WITH seq = 1 CONNECT BY prior seq+1 = seq ) tt
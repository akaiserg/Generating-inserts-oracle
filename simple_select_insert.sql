SELECT
    'Insert into main_table (id, name)  values ('|| rownum || ' , ' || ''''||name||'''' ||');' AS "insert  main table",
    'Insert into child_table (id, name)  values ('|| rownum || ' , ' || price||');'            AS  "insert  child table"
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
            dual )
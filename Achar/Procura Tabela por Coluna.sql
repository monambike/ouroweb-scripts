SELECT
  b.NAME,
  *
FROM
  SYS.COLUMNS a
    INNER JOIN
  SYS.TABLES b
      ON a.OBJECT_ID = b.OBJECT_ID
WHERE
  a.NAME LIKE ('%bit_UtilizaQtdeSolicitada%')
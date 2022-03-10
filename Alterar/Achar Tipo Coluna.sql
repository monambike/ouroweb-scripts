SELECT
	*
FROM
	SYS.COLUMNS
WHERE
	OBJECT_ID IN (SELECT
									OBJECT_ID
								FROM
									SYS.TABLES
								WHERE
									NAME = 'Mov_Estoque') AND
									SYSTEM_TYPE_ID IN (SELECT
																			XTYPE
																		FROM
																			SYS.SYSTYPES
																		WHERE
																			NAME = 'DATETIME')
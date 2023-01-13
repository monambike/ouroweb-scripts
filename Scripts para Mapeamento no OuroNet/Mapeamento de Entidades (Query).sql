-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER SUA TABELA
DECLARE @NomeTabela AS VARCHAR(100) = '<Nome da Tabela para Mapear, SYS.TABLE, >'


SELECT
	'Fields'	= 'private ' + (CASE c.NAME
                              WHEN 'bigint' THEN 'Int64?'
                              WHEN 'bit' THEN 'bool?'
                              WHEN 'char' THEN 'string'
                              WHEN 'datetime' THEN 'DateTime?'
                              WHEN 'decimal' THEN 'decimal?'
                              WHEN 'float' THEN 'double?'
                              WHEN 'varbinary' THEN 'Byte[]'
                              WHEN 'image' THEN 'Byte[]'
                              WHEN 'int' THEN 'int?'
                              WHEN 'money' THEN 'decimal?'
                              WHEN 'nchar' THEN 'string'
                              WHEN 'ntext' THEN 'string'
                              WHEN 'numeric' THEN 'decimal?'
                              WHEN 'nvarchar' THEN 'string'
                              WHEN 'smalldatetime' THEN 'DateTime?'
                              WHEN 'smallint' THEN 'Int16?'
                              WHEN 'text' THEN 'string'
                              WHEN 'tinyint' THEN 'Byte?'
                              WHEN 'varchar' THEN 'string'
                              ELSE 'null'
                            END) + ' ' + dbo.AjustaNomeCampoFramework(a.NAME, 1) + ';',
	'Properties'	= '/// <summary>' + CHAR(13) + CHAR(10) +
							    '/// Representa o campo ' + a.NAME + ' da tabela ' + b.NAME + '.' + CHAR(13) + CHAR(10) +
							    '/// </summary>' + CHAR(13) + CHAR(10) +
							    '[DataMember]' + CHAR(13) + CHAR(10) +
                  '[DataField("' + dbo.AjustaNomeCampoFramework(a.NAME, DEFAULT) + '"' + (CASE WHEN a.is_identity = 1 THEN ', PrimaryKey = true' ELSE '' END) + ', FieldNameTable = "' + a.NAME + '"' +
								    (CASE c.NAME 
										   WHEN 'char' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length)
										   WHEN 'nchar' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length / 2)
										   WHEN 'ntext' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length)
										   WHEN 'nvarchar' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length / 2)
										   WHEN 'text' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length)
										   WHEN 'varchar' THEN ', MaxLength = ' + CONVERT(VARCHAR, a.max_length) ELSE '' END) + 
								    (CASE c.NAME 
										   WHEN 'char' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END)
										   WHEN 'nchar' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END)
										   WHEN 'ntext' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END)
										   WHEN 'nvarchar' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END)
										   WHEN 'text' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END)
										   WHEN 'varchar' THEN (CASE WHEN a.is_nullable = 1 THEN ', AllowNull = true' ELSE '' END) ELSE '' END) + ')]' + CHAR(13) + CHAR(10) +
							    '[DbParameter(DbType.' + (CASE c.NAME
																					    WHEN 'bigint' THEN 'Int64'
																					    WHEN 'bit' THEN 'Boolean'
																					    WHEN 'char' THEN 'String'
																					    WHEN 'datetime' THEN 'DateTime'
																					    WHEN 'decimal' THEN 'Decimal'
																					    WHEN 'float' THEN 'Double'
																					    WHEN 'varbinary' THEN 'Binary'
																					    WHEN 'image' THEN 'Binary'
																					    WHEN 'int' THEN 'Int32'
																					    WHEN 'money' THEN 'Decimal'
																					    WHEN 'nchar' THEN 'StringFixedLength'
																					    WHEN 'ntext' THEN 'String'
																					    WHEN 'numeric' THEN 'Decimal'
																					    WHEN 'nvarchar' THEN 'String'
																					    WHEN 'smalldatetime' THEN 'DateTime'
																					    WHEN 'smallint' THEN 'Int16'
																					    WHEN 'text' THEN 'String'
																					    WHEN 'tinyint' THEN 'Byte'
																					    WHEN 'varchar' THEN 'String'
																					    ELSE 'null'
																				   END) + ', ParameterDirection.Input, Name = "' + dbo.AjustaNomeCampoFramework(a.NAME, DEFAULT) + '")]' + CHAR(13) + CHAR(10) +
							    'public ' + (CASE c.NAME
														     WHEN 'bigint' THEN 'Int64?'
														     WHEN 'bit' THEN 'bool?'
														     WHEN 'char' THEN 'string'
														     WHEN 'datetime' THEN 'DateTime?'
														     WHEN 'decimal' THEN 'decimal?'
														     WHEN 'float' THEN 'double?'
														     WHEN 'varbinary' THEN 'Byte[]'
														     WHEN 'image' THEN 'Byte[]'
														     WHEN 'int' THEN 'int?'
														     WHEN 'money' THEN 'decimal?'
														     WHEN 'nchar' THEN 'string'
														     WHEN 'ntext' THEN 'string'
														     WHEN 'numeric' THEN 'decimal?'
														     WHEN 'nvarchar' THEN 'string'
														     WHEN 'smalldatetime' THEN 'DateTime?'
														     WHEN 'smallint' THEN 'Int16?'
														     WHEN 'text' THEN 'string'
														     WHEN 'tinyint' THEN 'Byte?'
														     WHEN 'varchar' THEN 'string'
														     ELSE 'null'
													     END) + ' ' + dbo.AjustaNomeCampoFramework(a.NAME, DEFAULT) + 
							    ' { get { return ' + dbo.AjustaNomeCampoFramework(a.NAME, 1) +' ;} set { ' + dbo.AjustaNomeCampoFramework(a.NAME, 1) + ' = value; OnPropertyChanged(); } }' + CHAR(13) + CHAR(10) +
                  CHAR(13) + CHAR(10)
FROM
	SYS.COLUMNS AS a WITH(NOLOCK)
		INNER JOIN
	SYS.TABLES AS b WITH(NOLOCK)
			ON a.OBJECT_ID = b.OBJECT_ID
		INNER JOIN
	sys.TYPES AS c WITH(NOLOCK)
		  ON a.user_type_id = c.user_type_id
WHERE
	b.NAME = @NomeTabela
ORDER BY
	a.column_id
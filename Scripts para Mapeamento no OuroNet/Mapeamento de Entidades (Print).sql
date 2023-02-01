/******************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Script que serve como auxílio ao mapeamento de entidades para o OuroNet.

  Referências: https://stackoverflow.com/questions/5873170/generate-class-from-database-table

******************************************************************************/

DECLARE @TableName SYSNAME = '<Nome da Tabela, , >'

DECLARE @Result VARCHAR(MAX) = ''
SET @Result =
'///<sumary>
///<sumary>Entidade que representa a tabela (' + @TableName + ')
///<sumary>
'
SET @Result = @Result + 'public class ' + @TableName + '
{'

SELECT
  @Result = @Result + '
    ///<sumary>
    ///<sumary>Propriedade que representa o campo (' + ColumnName + ')
    ///<sumary>
    public ' + ColumnType + NullableSign + ' ' + ColumnName + ' { get; set; }
'
FROM
(
    SELECT
      REPLACE(col.name, ' ', '_') AS ColumnName
    , column_id                   AS ColumnId
    , CASE typ.name
        WHEN 'bigint'           THEN 'long'
        WHEN 'binary'           THEN 'byte[]'
        WHEN 'bit'              THEN 'bool'
        WHEN 'char'             THEN 'string'
        WHEN 'date'             THEN 'DateTime'
        WHEN 'datetime'         THEN 'DateTime'
        WHEN 'datetime2'        THEN 'DateTime'
        WHEN 'datetimeoffset'   THEN 'DateTimeOffset'
        WHEN 'decimal'          THEN 'decimal'
        WHEN 'float'            THEN 'float'
        WHEN 'image'            THEN 'byte[]'
        WHEN 'int'              THEN 'int'
        WHEN 'money'            THEN 'decimal'
        WHEN 'nchar'            THEN 'string'
        WHEN 'ntext'            THEN 'string'
        WHEN 'numeric'          THEN 'decimal'
        WHEN 'nvarchar'         THEN 'string'
        WHEN 'real'             THEN 'double'
        WHEN 'smalldatetime'    THEN 'DateTime'
        WHEN 'smallint'         THEN 'short'
        WHEN 'smallmoney'       THEN 'decimal'
        WHEN 'text'             THEN 'string'
        WHEN 'time'             THEN 'TimeSpan'
        WHEN 'timestamp'        THEN 'DateTime'
        WHEN 'tinyint'          THEN 'byte'
        WHEN 'uniqueidentifier' THEN 'Guid'
        WHEN 'varbinary'        THEN 'byte[]'
        WHEN 'varchar'          THEN 'string'
        ELSE 'UNKNOWN_' + typ.name
      END                         AS ColumnType
    , CASE
        WHEN col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') THEN '?'
        ELSE ''
      END                         AS NullableSign
    FROM
      sys.columns col
        INNER JOIN
      sys.types typ
          ON col.system_type_id = typ.system_type_id
          AND col.user_type_id = typ.user_type_id
    where
      object_id = object_id(@TableName)
) t
ORDER BY
  ColumnId

SET @Result = @Result  + '
}'

PRINT @Result

/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a criação do arquivo de configuração de
  conexões do "OuroNet" referente ao arquivo "Configuration Server".
  Para rodar basta rodar esse Script em qualquer base de uma instância que você deseje
  obter a lista de todas as bases.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

-- =============================================
-- Retornando os requisitos e realizando a montagem
-- de como eles vão ficar no template.
-- =============================================
-- Cursor para percorrer os registros
DECLARE [Database] CURSOR LOCAL FOR
  SELECT [name] FROM sys.databases WHERE [name] NOT IN ('master', 'tempdb', 'model', 'msdb') ORDER BY [name]
OPEN [Database]
  DECLARE @Name AS VARCHAR(MAX)
  FETCH NEXT FROM [Database] INTO @Name

  DECLARE @Databases AS VARCHAR(MAX) = ''
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Databases += '
            <database name="' + @Name + '" key="OuroWeb_' + @Name + '">
              <auxiliarydatabases>
                <auxdatabase name="OuroReports" key="OuroReports_' + @Name + '"/>
              </auxiliarydatabases>
            </database>'
    FETCH NEXT FROM [Database] INTO @Name
  END
-- Fechando o cursor para leitura
CLOSE [Database]
-- Finalizado o cursor
DEALLOCATE [Database]

DECLARE @Result AS VARCHAR(MAX) =
'<?xml version="1.0" encoding="utf-8" ?>
<custom.configuration.server>
  <products>
    <product name="OuroWeb" encryptionType="Crypto" serializationType="Json" compressionType="GZipCompression">
      <enterprises>
        <enterprise key="1" enterpriseName="nenhuma dentro do arquivo ''connectionStrings.config'' ou ''custom.configuration.server.config''">
          <databases>

            <!-- ' + @@SERVERNAME + '-->' + @Databases + CHAR(13) + CHAR(10) + '
          </databases>
        </enterprise>
      </enterprises>
    </product>
  </products>
</custom.configuration.server>'

PRINT CAST(@Result AS NTEXT)

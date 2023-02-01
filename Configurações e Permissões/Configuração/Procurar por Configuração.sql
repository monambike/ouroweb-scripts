/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e par�metros a serem
  utilizados nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por configura��es, bem como seus
  m�dulos e realizar a dele��o dos mesmos.

  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  Se voc� quiser habilitar a permiss�o voc� pode utilizar o seguinte comando:
  UPDATE tab_ConfigCampoAtributo SET str_ValorAtributo = 1 WHERE fk_int_ConfigCampo = @ConfigCampoID 

  Na coluna na qual � destacada os m�dulos em quais essa permiss�o est�, voc� encontrar�
  entre par�nteses o ID da rela��o do m�dulo com a configura��o. Voc� pode remover esse
  v�nculo utilizando o comando abaixo:
  DELETE FROM [tab_ConfigCampoMod] WHERE [pk_int_ConfigCampoMod] = @ID

**************************************************************************************/

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetModules]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetModules]
GO
CREATE FUNCTION [dbo].[GetModules] (@ConfiguracaoID AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Modules VARCHAR(MAX) = '| '

  SELECT
    @Modules += [Configuracao].[str_NomeMod] + ' (' + CAST([ModuloConfiguracao].[pk_int_ConfigCampoMod] AS VARCHAR(MAX)) +') | '
  FROM
    [tab_ConfigCampoMod] AS "ModuloConfiguracao"
    INNER JOIN
    [tab_ConfigMod]      AS "Configuracao" ON [ModuloConfiguracao].[fk_int_ConfigMod] = [Configuracao].[pk_int_ConfigMod]
  WHERE
    [ModuloConfiguracao].[fk_int_ConfigCampo] = @ConfiguracaoID
  GROUP BY
    [Configuracao].[str_NomeMod]
  , [ModuloConfiguracao].[pk_int_ConfigCampoMod]
  IF @Modules = '| ' SET @Modules = ''

  RETURN @Modules
END
GO

DECLARE
  @ConfigNameDescription AS VARCHAR(MAX) = '<Nome/Descri��o da Configura��o, VARCHAR(MAX), >'
, @Module                AS VARCHAR(MAX) = '<M�dulo da Configura��o, VARCHAR(MAX), >'

SELECT
  [configuracao].[pk_int_ConfigCampo]                     AS "ConfigCampoID"
, [configuracao].[str_NomeCampo]                          AS "Nome do Campo da Configura��o"
, [configuracao].[str_DescricaoCampo]                     AS "Descri��o da Configura��o"
, [dbo].[GetModules]([configuracao].[pk_int_ConfigCampo]) AS "M�dulos nos Quais Essa Permiss�o Est�"
FROM
  [tab_ConfigCampo] AS [configuracao]
WHERE
      (@ConfigNameDescription IN ('', CHAR(60) + 'Nome/Descri��o da Configura��o, VARCHAR(MAX), ' + CHAR(62))
         OR ([configuracao].[str_NomeCampo]      LIKE '%' + @ConfigNameDescription + '%'
         OR [configuracao].[str_DescricaoCampo]  LIKE '%' + @ConfigNameDescription + '%'))
  AND (@Module IN ( '',  CHAR(60) + 'M�dulo da Configura��o, VARCHAR(MAX), ' + CHAR(62))
         OR @Module LIKE ('%| ' + @Module + ' |%'))
ORDER BY 
  [configuracao].[str_NomeCampo]

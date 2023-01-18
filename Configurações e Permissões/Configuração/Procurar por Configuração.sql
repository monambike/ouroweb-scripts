/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por permissões.

  Se você quiser habilitar a permissão você pode utilizar o seguinte comando:
  UPDATE tab_ConfigCampoAtributo SET str_ValorAtributo = 1 WHERE fk_int_ConfigCampo = @PrimaryKeyDaPermissao 

**************************************************************************************/

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetModules]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetModules]
GO
CREATE FUNCTION GetModules (@PkConfiguracao AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Modules VARCHAR(MAX) = '| '

  SELECT
    @Modules += CAST([nomeconfiguracao].[str_NomeMod] AS VARCHAR(MAX)) + ' | '
  FROM
    [tab_ConfigCampoMod] AS [nomeconfiguracao_configuracao]
    INNER JOIN
    [tab_ConfigMod]      AS [nomeconfiguracao] ON [nomeconfiguracao_configuracao].fk_int_ConfigMod = [nomeconfiguracao].[pk_int_ConfigMod]
  WHERE
    [nomeconfiguracao_configuracao].[fk_int_ConfigCampo] = @PkConfiguracao
  GROUP BY
    [nomeconfiguracao].[str_NomeMod]
  
  IF @Modules = '| ' SET @Modules = ''
  RETURN @Modules
END
GO

DECLARE
    @ConfigNameDescription AS VARCHAR(MAX) = '<Nome/Descrição da Configuração, VARCHAR(MAX), >'
  , @Module                AS VARCHAR(MAX) = '<Módulo da Configuração, VARCHAR(MAX), >'

SELECT
    [configuracao].[pk_int_ConfigCampo]                     AS [ConfigCampoID]
  , [configuracao].[str_NomeCampo]                          AS [Nome do Campo da Configuração]
  , [configuracao].[str_DescricaoCampo]                     AS [Descrição da Configuração]
  , [dbo].[GetModules]([configuracao].[pk_int_ConfigCampo]) AS [Módulos nos Quais Essa Permissão Está]
FROM
  [tab_ConfigCampo] AS [configuracao]
WHERE
      (@ConfigNameDescription IN ('', CHAR(60) + 'Nome/Descrição da Configuração, VARCHAR(MAX), ' + CHAR(62))
         OR ([configuracao].[str_NomeCampo]      LIKE '%' + @ConfigNameDescription + '%'
         OR [configuracao].[str_DescricaoCampo]  LIKE '%' + @ConfigNameDescription + '%'))
  AND (@Module IN ( '',  CHAR(60) + 'Módulo da Configuração, VARCHAR(MAX), ' + CHAR(62))
         OR @Module LIKE ('%| ' + @Module + ' |%'))

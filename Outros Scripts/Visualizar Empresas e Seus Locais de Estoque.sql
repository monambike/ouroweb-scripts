/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a visualiza��o por Empresas e seus locais de
  estoque.

**************************************************************************************/

SELECT
  [Empresa].[IdEmpresa]            AS [IdEmpresa]
, [Empresa].[Empresa]              AS [Empresa]
, [LocalEstoque].[IdLocal]         AS [IdLocal]
, [LocalEstoque].[Descri��oLocal]  AS [Descri��oLocal]
, [Empresa].[IdLocalEstoquePadr�o] AS [IdLocalEstoquePadr�o]
, [Empresa].[Estado]               AS [Estado]
, [Cidade].[Cidade]                AS [Cidade]
, [Empresa].[Pa�s]                 AS [Pa�s]
, [Empresa].[Endere�o]             AS [Endere�o]
, [Empresa].[Bairro]               AS [Bairro]
, [Empresa].[str_complemento]      AS [Complemento]
FROM
  [Tab_Empresa]       AS [Empresa]
  INNER JOIN
  [Tab_LocaisEstoque] AS [LocalEstoque] ON [LocalEstoque].IDEmpresa = [Empresa].IdEmpresa
  INNER JOIN
  [Tab_Cidades]       AS [Cidade]       ON [Cidade].[IdCidade] = [Empresa].[IdCidade]
ORDER BY
  [Empresa].[IdEmpresa]
, [LocalEstoque].[IdLocal]

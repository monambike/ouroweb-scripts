/**************************************************************************************

  DESCRI��O
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a visualiza��o por Empresas e seus locais de
  estoque.

**************************************************************************************/

SELECT
  [a].[IdEmpresa]            AS [IdEmpresa],
  [a].[Empresa]              AS [Empresa],
  [b].[IdLocal]              AS [IdLocal],
  [b].[Descri��oLocal]       AS [Descri��oLocal],
  [a].[IdLocalEstoquePadr�o] AS [IdLocalEstoquePadr�o],
  [a].[Estado]               AS [Estado],
  [c].[Cidade]               AS [Cidade],
  [a].[Pa�s]                 AS [Pa�s],
  [a].[Endere�o]             AS [Endere�o],
  [a].[Bairro]               AS [Bairro],
  [a].[str_complemento]      AS [Complemento]
FROM
  [Tab_Empresa] AS [a]
  INNER JOIN
  [Tab_LocaisEstoque] AS [b] ON [a].IdEmpresa = [b].IDEmpresa
  INNER JOIN
  [Tab_Cidades] AS [c] ON [a].[IdCidade] = [c].[IdCidade]
ORDER BY
  [a].[IdEmpresa], [b].[IdLocal]
/**************************************************************************************

  DESCRIÇÃO
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a visualização por Empresas e seus locais de
  estoque.

**************************************************************************************/

SELECT
  [a].[IdEmpresa]            AS [IdEmpresa],
  [a].[Empresa]              AS [Empresa],
  [b].[IdLocal]              AS [IdLocal],
  [b].[DescriçãoLocal]       AS [DescriçãoLocal],
  [a].[IdLocalEstoquePadrão] AS [IdLocalEstoquePadrão],
  [a].[Estado]               AS [Estado],
  [c].[Cidade]               AS [Cidade],
  [a].[País]                 AS [País],
  [a].[Endereço]             AS [Endereço],
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
/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e parâmetros a serem utilizados
  nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por relatórios pelo seu nomes,
  descrições e estado ativo ou inativo, bem como o grupo em que está.


  ===================================================================================
   Filtros Selecionados
  ===================================================================================

  Mostrando relatórios que..
  Possuem nome ou descrição:            "<Filtrar por: Nome/Descrição do Relatório, VARCHAR(MAX), >"
  Relatório ativos ou inativos:         "<Filtrar por: Relatórios Ativos, BIT, >"
  Relatórios do grupo:                  "<Filtrar por: Grupo do Relatório, VARCHAR(MAX), >"
  Relatórios do grupo ativo ou inativo: "<Filtrar por: Grupos de Relatório Ativos, BIT, >"

**************************************************************************************/

DECLARE
  -- Relatório
    @SearchForRelatoryNameDescription AS VARCHAR(MAX) = '<Filtrar por: Nome/Descrição do Relatório, VARCHAR(MAX), >'
  , @ShowActiveRelatories             AS VARCHAR(MAX) = '<Filtrar por: Relatórios Ativos, BIT, >'
  -- Grupo do Relatório
  , @SearchForRelatoryGroup           AS VARCHAR(MAX) = '<Filtrar por: Grupo do Relatório, VARCHAR(MAX), >'
  , @ShowActiveRelatoryGroups         AS VARCHAR(MAX) = '<Filtrar por: Grupos de Relatório Ativos, BIT, >'


SELECT 
    [relatorio].[NomeRelatorio] AS [Nome do Relatório]
  , [relatorio].[Descricao]     AS [Descrição do Relatório]
  , [relatorio].[Ativo]         AS [Relatório Ativo]
  , [grupo].[Descricao]         AS [Grupo]
  , [grupo].[bit_Ativo]         AS [Grupo Ativo]
FROM
  [Tab_Relatorios]      AS [relatorio] WITH(NOLOCK)
  INNER JOIN
  [Tab_RelatoriosGrupo] AS [grupo]     WITH(NOLOCK) ON [relatorio].[IdRelatorioGrupo] = [grupo].[IdRelatorioGrupo]
WHERE
  (@SearchForRelatoryNameDescription = ''
    OR ([relatorio].[NomeRelatorio] + [relatorio].[Descricao] LIKE ('%' + @SearchForRelatoryNameDescription + '%')))
  AND (@SearchForRelatoryGroup   = '' OR [grupo].[Descricao] LIKE ('%' + @SearchForRelatoryGroup + '%'))
  AND (@ShowActiveRelatories     = '' OR [relatorio].[Ativo] = @ShowActiveRelatories)
  AND (@ShowActiveRelatoryGroups = '' OR [grupo].[bit_Ativo] = @ShowActiveRelatoryGroups)
ORDER BY
  [Descrição do Relatório]
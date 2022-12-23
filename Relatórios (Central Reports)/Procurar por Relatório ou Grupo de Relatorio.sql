/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e parâmetros a serem utilizados
  nesse template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por relatórios pelo seu nomes,
  descrições e estado ativo ou inativo, bem como o grupo em que está.


  SELECTED FILTERS
  -------------------------------------------------------------------------------------
  Mostrando relatórios que..
  Possuem nome ou descrição:            "<Filtrar por: Nome/Descrição do Relatório, VARCHAR, >"
  Relatório ativos ou inativos:         "<Filtrar por: Relatórios Ativos, VARCHAR, >"
  Relatórios do grupo:                  "<Filtrar por: Grupo do Relatório, VARCHAR, >"
  Relatórios do grupo ativo ou inativo: "<Filtrar por: Grupos de Relatório Ativos, VARCHAR, >"

**************************************************************************************/

DECLARE
  -- Relatório
  @SearchForRelatoryNameDescription AS VARCHAR(MAX) = '<Filtrar por: Nome/Descrição do Relatório, VARCHAR, >',
  @ShowActiveRelatories             AS VARCHAR(MAX) = '<Filtrar por: Relatórios Ativos, VARCHAR, >',
  -- Grupo do Relatório
  @SearchForRelatoryGroup           AS VARCHAR(MAX) = '<Filtrar por: Grupo do Relatório, VARCHAR, >',
  @ShowActiveRelatoryGroups         AS VARCHAR(MAX) = '<Filtrar por: Grupos de Relatório Ativos, VARCHAR, >'


SELECT 
  [a].[NomeRelatorio] AS [Nome do Relatório], 
  [a].[Descricao]     AS [Descrição do Relatório], 
  [a].[Ativo]         AS [Relatório Ativo],
  [b].[Descricao]     AS [Grupo],
  [b].[bit_Ativo]     AS [Grupo Ativo]
FROM
  [Tab_Relatorios] AS [a]
    INNER JOIN
  [Tab_RelatoriosGrupo] AS [b]
      ON [a].[IdRelatorioGrupo] = [b].[IdRelatorioGrupo]
WHERE
  (@SearchForRelatoryNameDescription = ''
    OR (([a].[NomeRelatorio] + [a].[Descricao]) LIKE ('%' + @SearchForRelatoryNameDescription + '%')))
  AND (@SearchForRelatoryGroup   = ''    OR [b].[Descricao] LIKE ('%' + @SearchForRelatoryGroup + '%'))
  AND (@ShowActiveRelatories     = '' OR [a].[Ativo] = @ShowActiveRelatories)
  AND (@ShowActiveRelatoryGroups = '' OR [b].[bit_Ativo] = @ShowActiveRelatoryGroups)
ORDER BY
  [Descrição do Relatório]
/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e par�metros a serem utilizados
  nesse template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por relat�rios pelo seu nomes,
  descri��es e estado ativo ou inativo, bem como o grupo em que est�.


  SELECTED FILTERS
  -------------------------------------------------------------------------------------
  Mostrando relat�rios que..
  Possuem nome ou descri��o:            "<Filtrar por: Nome/Descri��o do Relat�rio, VARCHAR, >"
  Relat�rio ativos ou inativos:         "<Filtrar por: Relat�rios Ativos, VARCHAR, >"
  Relat�rios do grupo:                  "<Filtrar por: Grupo do Relat�rio, VARCHAR, >"
  Relat�rios do grupo ativo ou inativo: "<Filtrar por: Grupos de Relat�rio Ativos, VARCHAR, >"

**************************************************************************************/

DECLARE
  -- Relat�rio
  @SearchForRelatoryNameDescription AS VARCHAR(MAX) = '<Filtrar por: Nome/Descri��o do Relat�rio, VARCHAR, >',
  @ShowActiveRelatories             AS VARCHAR(MAX) = '<Filtrar por: Relat�rios Ativos, VARCHAR, >',
  -- Grupo do Relat�rio
  @SearchForRelatoryGroup           AS VARCHAR(MAX) = '<Filtrar por: Grupo do Relat�rio, VARCHAR, >',
  @ShowActiveRelatoryGroups         AS VARCHAR(MAX) = '<Filtrar por: Grupos de Relat�rio Ativos, VARCHAR, >'


SELECT 
  [a].[NomeRelatorio] AS [Nome do Relat�rio], 
  [a].[Descricao]     AS [Descri��o do Relat�rio], 
  [a].[Ativo]         AS [Relat�rio Ativo],
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
  [Descri��o do Relat�rio]
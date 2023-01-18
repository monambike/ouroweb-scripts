/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e par�metros a serem utilizados
  nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por relat�rios pelo seu nomes,
  descri��es e estado ativo ou inativo, bem como o grupo em que est�.


  ===================================================================================
   Filtros Selecionados
  ===================================================================================

  Mostrando relat�rios que..
  Possuem nome ou descri��o:            "<Filtrar por: Nome/Descri��o do Relat�rio, VARCHAR(MAX), >"
  Relat�rio ativos ou inativos:         "<Filtrar por: Relat�rios Ativos, BIT, >"
  Relat�rios do grupo:                  "<Filtrar por: Grupo do Relat�rio, VARCHAR(MAX), >"
  Relat�rios do grupo ativo ou inativo: "<Filtrar por: Grupos de Relat�rio Ativos, BIT, >"

**************************************************************************************/

DECLARE
  -- Relat�rio
    @SearchForRelatoryNameDescription AS VARCHAR(MAX) = '<Filtrar por: Nome/Descri��o do Relat�rio, VARCHAR(MAX), >'
  , @ShowActiveRelatories             AS VARCHAR(MAX) = '<Filtrar por: Relat�rios Ativos, BIT, >'
  -- Grupo do Relat�rio
  , @SearchForRelatoryGroup           AS VARCHAR(MAX) = '<Filtrar por: Grupo do Relat�rio, VARCHAR(MAX), >'
  , @ShowActiveRelatoryGroups         AS VARCHAR(MAX) = '<Filtrar por: Grupos de Relat�rio Ativos, BIT, >'


SELECT 
    [relatorio].[NomeRelatorio] AS [Nome do Relat�rio]
  , [relatorio].[Descricao]     AS [Descri��o do Relat�rio]
  , [relatorio].[Ativo]         AS [Relat�rio Ativo]
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
  [Descri��o do Relat�rio]
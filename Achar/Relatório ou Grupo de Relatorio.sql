-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 APÓS ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForRelatoryName VARCHAR(MAX) = '<Filtrar por: Nome do Relatório, VARCHAR, >',
    @SearchForRelatoryDescription VARCHAR(MAX) = '<Filtrar por: Descrição do Relatório, VARCHAR, >',
    @ShowActiveRelatories AS BIT = <Filtrar por: Relatórios Ativos, BIT, NULL>

  DECLARE
    @SearchForRelatoryGroup VARCHAR(MAx) = '<Filtrar por: Grupo do Relatório, VARCHAR, >',
    @ShowActiveRelatoryGroups AS BIT = <Filtrar por: Grupos de Relatório Ativos, BIT, NULL>
END


BEGIN TRY
    BEGIN -- Process Execution
      SELECT 
	      a.NomeRelatorio AS 'Nome do Relatório', 
	      a.Descricao AS 'Descrição do Relatório', 
	      a.Ativo AS 'Relatório Ativo',
	      b.Descricao AS 'Grupo',
	      b.bit_Ativo AS 'Grupo Ativo'
      FROM
	      Tab_Relatorios a
		      INNER JOIN
	      Tab_RelatoriosGrupo b
			      ON a.IdRelatorioGrupo = b.IdRelatorioGrupo
      WHERE
        (@SearchForRelatoryName = '' OR a.NomeRelatorio LIKE ('%' + @SearchForRelatoryName + '%')) AND
        (@SearchForRelatoryDescription = '' OR a.Descricao LIKE ('%' + @SearchForRelatoryDescription + '%')) AND
        (@SearchForRelatoryGroup = '' OR b.Descricao LIKE ('%' + @SearchForRelatoryGroup + '%')) AND
        (@ShowActiveRelatories IS NULL OR a.Ativo = @ShowActiveRelatories) AND
        (@ShowActiveRelatoryGroups IS NULL OR b.bit_Ativo = @ShowActiveRelatoryGroups)
    END
END TRY
BEGIN CATCH
    PRINT('Ocorreu um erro desconhecido, por favor, tente novamente')
END CATCH
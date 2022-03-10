-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 AP�S ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForRelatoryName VARCHAR(MAX) = '<Filtrar por: Nome do Relat�rio, VARCHAR, >',
    @SearchForRelatoryDescription VARCHAR(MAX) = '<Filtrar por: Descri��o do Relat�rio, VARCHAR, >',
    @ShowActiveRelatories AS BIT = <Filtrar por: Relat�rios Ativos, BIT, NULL>

  DECLARE
    @SearchForRelatoryGroup VARCHAR(MAx) = '<Filtrar por: Grupo do Relat�rio, VARCHAR, >',
    @ShowActiveRelatoryGroups AS BIT = <Filtrar por: Grupos de Relat�rio Ativos, BIT, NULL>
END


BEGIN TRY
    BEGIN -- Process Execution
      SELECT 
	      a.NomeRelatorio AS 'Nome do Relat�rio', 
	      a.Descricao AS 'Descri��o do Relat�rio', 
	      a.Ativo AS 'Relat�rio Ativo',
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
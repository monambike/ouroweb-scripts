



SELECT
	a.Descricao as NomeRelatorio,
	b.Descricao as GrupoRelatorio
FROM
	Tab_Relatorios a
		inner join
	Tab_RelatoriosGrupo b
			on a.IdRelatorioGrupo = b.IdRelatorioGrupo
WHERE
	a.NomeRelatorio = 'MEQ_Ficha Separação'
	and a.Ativo = 1
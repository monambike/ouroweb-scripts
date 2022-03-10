declare @IdRelatorioGrupo int,
@NomeRelatorio nvarchar(100),
@DescricaoRelatorio nvarchar(100),
@NomeGrupo nvarchar(40)

set @NomeRelatorio = 'Rel_Relatorio de Insumos Comodato'				
set @DescricaoRelatorio = 'Relatório de Insumos Comodato'	
set @NomeGrupo = 'Comercial'							
set @IdRelatorioGrupo = (select 
													IdRelatorioGrupo
													from 
														Tab_RelatoriosGrupo 
													where  
														(Descricao = @NomeGrupo)
                         )
delete from 
	Tab_Relatorios 
where 
	(NomeRelatorio = @NomeRelatorio)
insert into 
	Tab_Relatorios (
		NomeRelatorio, 
		Descricao, 
		IdRelatorioGrupo, 
		Ativo
	) values (
		@NomeRelatorio, 
		@DescricaoRelatorio, 
		@IdRelatorioGrupo, 
		1)
delete from 
	Tab_SeçõesReports 
where 
	(NomeReport = @NomeRelatorio)
insert into 
	Tab_SeçõesReports(
		NomeReport, 
		IdSeçãoReport
	) values (
		@NomeRelatorio, 
		0)
GO


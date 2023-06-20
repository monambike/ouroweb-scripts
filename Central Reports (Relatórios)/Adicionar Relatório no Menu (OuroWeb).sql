/*[APAGUE ESSE COMENTÁRIO]*********************************************
Sugestão de Nome: XXX - Criar_Menu_<Nome do Relatório, , Mvt_Resumo de Movimento por Condição de Pagamento>
**********************************************************************/
declare @IdRelatorioGrupo int,
@NomeRelatorio nvarchar(100),
@DescricaoRelatorio nvarchar(100),
@NomeGrupo nvarchar(40)

set @NomeRelatorio = '<Nome do Relatório, , Mvt_Resumo de Movimento por Condição de Pagamento>'				
set @DescricaoRelatorio = '<Descrição do Relatório, , Resumo de Movimento por Condição de Pagamento>'	
set @NomeGrupo = '<Nome do Grupo, , Comercial>'							
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

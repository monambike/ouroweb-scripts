/*[APAGUE ESSE COMENT�RIO]*********************************************
Sugest�o de Nome: XXX - Criar_Menu_<Nome do Relat�rio, , Mvt_Resumo de Movimento por Condi��o de Pagamento>
**********************************************************************/
declare @IdRelatorioGrupo int,
@NomeRelatorio nvarchar(100),
@DescricaoRelatorio nvarchar(100),
@NomeGrupo nvarchar(40)

set @NomeRelatorio = '<Nome do Relat�rio, , Mvt_Resumo de Movimento por Condi��o de Pagamento>'				
set @DescricaoRelatorio = '<Descri��o do Relat�rio, , Resumo de Movimento por Condi��o de Pagamento>'	
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
	Tab_Se��esReports 
where 
	(NomeReport = @NomeRelatorio)
insert into 
	Tab_Se��esReports(
		NomeReport, 
		IdSe��oReport
	) values (
		@NomeRelatorio, 
		0)
GO

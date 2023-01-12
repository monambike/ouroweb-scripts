/******************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os parâmetros e valores a serem utilizados
  nesse template.

******************************************************************************/

declare @NomeTabela as varchar(200)
declare @ParametroPkTipo as varchar(200)
declare @ParametroPk as varchar(200)
declare @NomePk as varchar(200)
set @NomeTabela = '<Nome da Tabela, , >'


select
	@ParametroPkTipo = '@' + dbo.AjustaNomeCampoFramework(a.name, default) + ' ' + (case c.name
																																  						 when 'bigint' then c.name
																																  						 when 'bit' then c.name
																																  						 when 'char' then c.name + '(' + convert(varchar, a.max_length) + ')'
																																  						 when 'datetime' then c.name
																																  						 when 'decimal' then c.name + '(' + convert(varchar, a.precision) + ', ' + convert(varchar, a.scale)  + ')'
																																  						 when 'float' then c.name
																																  						 when 'varbinary' then c.name + '(' + (case when a.max_length = -1 then 'MAX' else convert(varchar, a.max_length) end) + ')'
																																  						 when 'int' then c.name
																																  						 when 'money' then c.name
																																  						 when 'nchar' then c.name + '(' + convert(varchar, a.max_length / 2) + ')'
																																  						 when 'ntext' then c.name
																																  						 when 'numeric' then c.name + '(' + convert(varchar, a.precision) + ', ' + convert(varchar, a.scale)  + ')'
																																  						 when 'nvarchar' then c.name + '(' + convert(varchar, a.max_length / 2) + ')'
																																  						 when 'smalldatetime' then c.name
																																  						 when 'smallint' then c.name
																																  						 when 'text' then c.name
																																  						 when 'tinyint' then c.name
																																  						 when 'varchar' then c.name + '(' + convert(varchar, a.max_length) + ')'
																																							 else '[NotFound]'
																																						 end),
	@NomePk = a.name,
	@ParametroPk = '@' + dbo.AjustaNomeCampoFramework(a.name, default)
from
	sys.columns as a with(nolock)
		inner join
	sys.tables as b with(nolock)
			on a.object_id = b.object_id
		inner join
	sys.types as c with(nolock)
			on a.user_type_id = c.user_type_id
where
	b.name = @NomeTabela and
	a.is_identity = 1

select
	'Procedure' = '/******************************************************************************' + char(13) + char(10) +
								char(9) + 'Descrição: Criar_Procedure_usp_mng_Delete_' + @NomeTabela + char(13) + char(10) +
								'*******************************************************************************/' + char(13) + char(10) +
								'if exists (select * from sysobjects where type = ''p'' and name = ''usp_mng_Delete_' + @NomeTabela + ''')' + char(13) + char(10) +
								char(9) + 'begin' + char(13) + char(10) +
								replicate(char(9), 2) + 'print ''Removendo Procedure usp_mng_Delete_' + @NomeTabela + '''' + char(13) + char(10) +
								replicate(char(9), 2) + 'drop procedure usp_mng_Delete_' + @NomeTabela + char(13) + char(10) +
								char(9) + 'end' + char(13) + char(10) +
								'go' + char(13) + char(10) +
								'print ''Criando Procedure usp_mng_Delete_' + @NomeTabela + '''' + char(13) + char(10) +
								'go' + char(13) + char(10) + char(13) + char(10) +
								'create procedure usp_mng_Delete_' + @NomeTabela + char(13) + char(10) +
								replicate(char(9), 14) + '(' + @ParametroPkTipo + ')' + char(13) + char(10) +
								'as' + replicate(char(13) + char(10), 2) + 
								'delete from' + char(13) + char(10) +
								char(9) + @NomeTabela + char(13) + char(10) +
								'where' + char(13) + char(10) +
								char(9) + @NomePk + ' = ' + @ParametroPk + replicate(char(13) + char(10), 2) +
								'go' + char(13) + char(10) +
								'grant exec on usp_mng_Delete_' + @NomeTabela + ' to public' + char(13) + char(10) +
								'go'
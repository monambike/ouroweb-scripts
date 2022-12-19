declare @NomeTabela as varchar(200)
set @NomeTabela = 'Tab_Cadastro_Departamento' --<< Insira o nome da tabela aqui!

declare @Parametros as varchar(max)
declare @NomeParametro as varchar(200)
declare #cursorParametros cursor for
select
	'Parametro'	= '@' + dbo.AjustaNomeCampoFramework(a.name, default) + ' ' + (case c.name
																																							 when 'bigint' then c.name
																																							 when 'bit' then c.name
																																							 when 'char' then c.name + '(' + convert(varchar, a.max_length) + ')'
																																							 when 'datetime' then c.name
																																							 when 'decimal' then c.name
																																							 when 'float' then c.name
																																							 when 'varbinary' then c.name + '(' + (case when a.max_length = -1 then 'MAX' else convert(varchar, a.max_length) end) + ')'
																																							 when 'int' then c.name
																																							 when 'money' then c.name
																																							 when 'nchar' then c.name + '(' + convert(varchar, a.max_length / 2) + ')'
																																							 when 'ntext' then c.name
																																							 when 'numeric' then c.name
																																							 when 'nvarchar' then c.name + '(' + convert(varchar, a.max_length / 2) + ')'
																																							 when 'smalldatetime' then c.name
																																							 when 'smallint' then c.name
																																							 when 'text' then c.name
																																							 when 'tinyint' then c.name																					
																																							 when 'varchar' then c.name + '(' + convert(varchar, a.max_length) + ')'
																																							 else '[NotFound]'
																																						 end) + (case
																																											 when a.is_identity = 1 or a.is_nullable = 1
																																												 then ' = null'
																																											 else (case
																																															 when a.default_object_id > 0
																																																 then ' = ' + replace(replace(object_definition(a.default_object_id), '(', ''), ')', '')
																																															 else ''
																																														 end)
																																										 end)
from
	sys.columns as a with(nolock)
		inner join
	sys.tables as b with(nolock)
			on a.object_id = b.object_id
		inner join
	sys.types as c with(nolock)
			on a.user_type_id = c.user_type_id
where
	b.name = @NomeTabela
order by
	a.column_id
open
	#cursorParametros
fetch next
from
	#cursorParametros
into @NomeParametro

while (@@fetch_status = 0)
	begin
		
		if (isnull(@Parametros, '') = '')
			begin
				set @Parametros = @NomeParametro
			end
		else
			begin
				set @Parametros = @Parametros + ', ' + char(13) + char(10) + replicate(char(9), 14) + ' ' + @NomeParametro
			end

		fetch next
		from
			#cursorParametros
		into @NomeParametro
	end

close #cursorParametros
deallocate #cursorParametros

declare @campos as varchar(max)
declare @values as varchar(max)
declare @NomeValue as varchar(200)
declare @Nomecampo varchar(200)
declare #cursorCampos cursor for
select
	'Campo'	= a.name,
	'Values' = '@' + dbo.AjustaNomeCampoFramework(a.name, default)
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
	a.is_identity = 0
order by
	a.column_id
open
	#cursorCampos
fetch next
from
	#cursorCampos
into @Nomecampo, @NomeValue

while (@@fetch_status = 0)
	begin
		
		if (isnull(@campos, '') = '')
			begin
				set @campos = @Nomecampo
				set @values = @NomeValue
			end
		else
			begin
				set @campos = @campos + ', ' + char(13) + char(10) + char(9) + ' ' + @Nomecampo
				set @values = @values + ', ' + char(13) + char(10) + char(9) + ' ' + @NomeValue
			end

		fetch next
		from
			#cursorCampos
		into @Nomecampo,  @NomeValue
	end

close #cursorCampos
deallocate #cursorCampos

select
	'Procedure' = '/******************************************************************************' + char(13) + char(10) +
								char(9) + 'Descrição: Criar_Procedure_usp_mng_Insert_' + @NomeTabela + char(13) + char(10) +
								'*******************************************************************************/' + char(13) + char(10) +
								'if exists (select * from sysobjects where type = ''p'' and name = ''usp_mng_Insert_' + @NomeTabela + ''')' + char(13) + char(10) +
								char(9) + 'begin' + char(13) + char(10) +
								replicate(char(9), 2) + 'print ''Removendo Procedure usp_mng_Insert_' + @NomeTabela + '''' + char(13) + char(10) +
								replicate(char(9), 2) + 'drop procedure usp_mng_Insert_' + @NomeTabela + char(13) + char(10) +
								char(9) + 'end' + char(13) + char(10) +
								'go' + char(13) + char(10) +
								'print ''Criando Procedure usp_mng_Insert_' + @NomeTabela + '''' + char(13) + char(10) +
								'go' + char(13) + char(10) + char(13) + char(10) +
								'create procedure usp_mng_Insert_' + @NomeTabela + char(13) + char(10) +
								replicate(char(9), 14) + '(' + @Parametros + ')' + char(13) + char(10) +
								'as' + replicate(char(13) + char(10), 2) +
								'insert into ' + @NomeTabela + char(13) + char(10) +
								char(9) + '(' + @campos + ')' + char(13) + char(10) +
								'values' + char(13) + char(10) +
								char(9) + '(' + @values + ')' + char(13) + char(10) + char(13) + char(10) +
								'select cast(SCOPE_IDENTITY() as int)' + char(13) + char(10) + char(13) + char(10) +
								'go' + char(13) + char(10) +
								'grant exec on usp_mng_Insert_' + @NomeTabela + ' to public' + char(13) + char(10) +
								'go'
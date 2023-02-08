/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo de criar procedures de listagem de dados para tabelas
  existentes.

**************************************************************************************/

DECLARE @NomeTabela AS SYSNAME = '<Nome da Tabela, SYSNAME, >'
declare @Parametros as varchar(max)
declare @NomeParametro as varchar(200)
declare #cursorParametros cursor for
select
  'Parametro' = '@' + dbo.AjustaNomeCampoFramework(a.name, default) + ' ' + (case c.name
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
                                                                             end) + ' = null'
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

declare @corpo as varchar(max)

declare @campos as varchar(max)
declare @where as varchar(max)
declare @values as varchar(max)
declare @NomeValue as varchar(200)
declare @Nomecampo varchar(200)
declare @NomeCorpo varchar(200)
declare @NomeWhere varchar(1000)
declare #cursorCampos cursor for
select
  'Corpo' = '''' + dbo.AjustaNomeCampoFramework(a.name, default) + ''''  + ' = a.' + a.name,
  'Where'  = (case
               when c.name = 'text' or c.name = 'ntext' or c.name = 'char' or c.name = 'nchar' or c.name = 'ntext' or c.name = 'nvarchar' or c.name = 'varchar'
                 then '(@' + dbo.AjustaNomeCampoFramework(a.name, default) + ' is null or a.' + a.name + ' like @' + dbo.AjustaNomeCampoFramework(a.name, default) + ')'
               when c.name = 'image' or c.name = 'varbinary'
                 then null
               else '(@' + dbo.AjustaNomeCampoFramework(a.name, default) + ' is null or a.' + a.name + ' = @' + dbo.AjustaNomeCampoFramework(a.name, default) + ')'
             end),
  'Campo'  = a.name,
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
  b.name = @NomeTabela
order by
  a.column_id
open
  #cursorCampos
fetch next
from
  #cursorCampos
into @NomeCorpo, @NomeWhere, @Nomecampo, @NomeValue

while (@@fetch_status = 0)
  begin
    
    if (isnull(@campos, '') = '')
      begin
        set @campos = @Nomecampo
        set @values = @NomeValue
        set @corpo = @NomeCorpo
        set @where = @NomeWhere
      end
    else
      begin
        set @campos = @campos + ', ' + char(13) + char(10) + char(9) + @Nomecampo
        set @values = @values + ', ' + char(13) + char(10) + char(9) + @NomeValue      
        set @corpo = @corpo + ', ' + char(13) + char(10) + char(9) + @NomeCorpo
        set @where = @where + ' and ' + char(13) + char(10) + char(9) + @NomeWhere
      end

    fetch next
    from
      #cursorCampos
    into @NomeCorpo, @NomeWhere, @Nomecampo,  @NomeValue
  end

close #cursorCampos
deallocate #cursorCampos

select  
  'Procedure' = '/******************************************************************************' + char(13) + char(10) +
                char(9) + 'Descrição: Criar_Procedure_usp_lst_' + @NomeTabela + char(13) + char(10) +
                '*******************************************************************************/' + char(13) + char(10) +
                'if exists (select * from sysobjects where type = ''p'' and name = ''usp_lst_' + @NomeTabela + ''')' + char(13) + char(10) +
                char(9) + 'begin' + char(13) + char(10) +
                replicate(char(9), 2) + 'print ''Removendo Procedure usp_lst_' + @NomeTabela + '''' + char(13) + char(10) +
                replicate(char(9), 2) + 'drop procedure usp_lst_' + @NomeTabela + char(13) + char(10) +
                char(9) + 'end' + char(13) + char(10) +
                'go' + char(13) + char(10) +
                'print ''Criando Procedure usp_lst_' + @NomeTabela + '''' + char(13) + char(10) +
                'go' + char(13) + char(10) + char(13) + char(10) +
                'create procedure usp_lst_' + @NomeTabela + char(13) + char(10) +
                replicate(char(9), 14) + '(' + @Parametros + ')' + char(13) + char(10) +
                'as' + replicate(char(13) + char(10), 2) +
                'select ' + char(13) + char(10) +
                char(9) + @corpo + char(13) + char(10) +
                'from' + char(13) + char(10) +
                char(9) + @NomeTabela + ' a with(nolock)' + char(13) + char(10) +
                'where' + char(13) + char(10) +
                char(9) + @where + char(13) + char(10) + char(13) + char(10) +                
                'go' + char(13) + char(10) +
                'grant exec on usp_lst_' + @NomeTabela + ' to public' + char(13) + char(10) +
                'go'
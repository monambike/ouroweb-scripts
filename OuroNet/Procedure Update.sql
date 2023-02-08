/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo de criar procedures de atualização de dados para tabelas
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
                                                                             end)  + ' = null'
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

declare @set as varchar(max)
declare @where as varchar(max)
declare @NomeSet as varchar(200)
declare @NomeWhere varchar(200)
declare #cursorCampos cursor for
select
  'Set'  = (case
             when a.is_identity = 0
               then a.name + ' = @' + dbo.AjustaNomeCampoFramework(a.name, default)
           end),  
  'Where'  = (case
               when a.is_identity = 1
                 then a.name + ' = @' + dbo.AjustaNomeCampoFramework(a.name, default)
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
  #cursorCampos
fetch next
from
  #cursorCampos
into @NomeSet, @NomeWhere

while (@@fetch_status = 0)
  begin
    
    if (isnull(@set, '') = '')
      begin
        if (@NomeSet is not null)
          begin
            set @set = @NomeSet
          end
      end
    else
      begin
        if (@NomeSet is not null)
          begin
            set @set = @set + ', ' + char(13) + char(10) + char(9) + @NomeSet
          end
      end

    if (isnull(@NomeWhere, '') <> '')
      begin        
        set @where = @NomeWhere
      end    

    fetch next
    from
      #cursorCampos
    into @NomeSet, @NomeWhere
  end

close #cursorCampos
deallocate #cursorCampos

select  
  'Procedure' = '/******************************************************************************' + char(13) + char(10) +
                char(9) + 'Descrição: Criar_Procedure_usp_mng_Update_' + @NomeTabela + char(13) + char(10) +
                '*******************************************************************************/' + char(13) + char(10) +
                'if exists (select * from sysobjects where type = ''p'' and name = ''usp_mng_Update_' + @NomeTabela + ''')' + char(13) + char(10) +
                char(9) + 'begin' + char(13) + char(10) +
                replicate(char(9), 2) + 'print ''Removendo Procedure usp_mng_Update_' + @NomeTabela + '''' + char(13) + char(10) +
                replicate(char(9), 2) + 'drop procedure usp_mng_Update_' + @NomeTabela + char(13) + char(10) +
                char(9) + 'end' + char(13) + char(10) +
                'go' + char(13) + char(10) +
                'print ''Criando Procedure usp_mng_Update_' + @NomeTabela + '''' + char(13) + char(10) +
                'go' + char(13) + char(10) + char(13) + char(10) +
                'create procedure usp_mng_Update_' + @NomeTabela + char(13) + char(10) +
                replicate(char(9), 14) + '(' + @Parametros + ')' + char(13) + char(10) +
                'as' + replicate(char(13) + char(10), 2) +
                'update ' + char(13) + char(10) +
                char(9) + @NomeTabela + char(13) + char(10) +
                'set ' + char(13) + char(10) +
                char(9) + @set + char(13) + char(10) +
                'where' + char(13) + char(10) +
                char(9) + isnull(@where, 'Tabela sem campo Identity') + char(13) + char(10) + char(13) + char(10) +                
                'go' + char(13) + char(10) +
                'grant exec on usp_mng_Update_' + @NomeTabela + ' to public' + char(13) + char(10) +
                'go'

/******************************************************************************
		Descrição: 
			677446
            
		Chamada por:
            
			
		DataBase:
		OBS:
		 
		 select dbo.fn_lst_RetornoAmparoFiscal(11939)
         select dbo.fn_lst_RetornoAmparoFiscal()
         
*******************************************************************************/

if exists (select * from sysobjects where type IN ('TF','FN') and name = 'fn_lst_RetornoAmparoFiscal')
	begin
		print 'Removendo Function fn_lst_RetornoAmparoFiscal'
		drop function fn_lst_RetornoAmparoFiscal
	end
go

print 'Criando Function fn_lst_RetornoAmparoFiscal'
go

create function fn_lst_RetornoAmparoFiscal(@int_idMovimento INT)

returns varchar(max)

as

	BEGIN

		DECLARE 
		  @str_Msg varchar(max),
			@str_Msg2 varchar(max)
						
      set @str_Msg = ''
			set @str_Msg2 = ''

	    DECLARE db_cursor CURSOR FOR  

			select 
				d.str_MsgAmparo
			from 
				Mov_Estoque a
					inner join
				Mov_Estoque_Detalhes b
						on a.IdMovimento = b.IdMovimento
					left join
				Tab_Estoque_PisCofins c
						on b.IdItem = c.str_IdItem
					left join
				AmparoLegalPISCOFINS d
						on c.fk_int_AmparoLegalPISCOFINS = d.pk_int_AmparoLegalPISCOFINS
			where 
				d.str_MsgAmparo is not null
				and a.IdMovimento = @int_idMovimento
			group by
				a.IdMovimento, d.str_MsgAmparo
				
			
			OPEN db_cursor   
			    FETCH NEXT FROM db_cursor INTO @str_Msg2
                WHILE @@FETCH_STATUS = 0   
					BEGIN   
							SET 	@str_Msg = @str_Msg + @str_Msg2 + ' / '
							FETCH NEXT FROM db_cursor INTO @str_Msg2
			        END   
			    CLOSE db_cursor   
			
		DEALLOCATE db_cursor
	 
		return @str_Msg

	END
go

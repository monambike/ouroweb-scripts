/**********************************************************************
		Descri��o: 
			
					
		OBS: 
						
**********************************************************************/

if not exists (select * from syscolumns where id = object_id('<table_name>') and name in('<column_name>'))
	begin
		print 'Criando a(s) coluna(s) (<column_name>, <column_name>)'
		
		/* Colocar c�digo da cria��o das colunas sem o 'Go' no final das instru��es */

	end
go

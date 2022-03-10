/**********************************************************************
		Descrição: 
			
					
		OBS: 
						
**********************************************************************/

if not exists (select * from syscolumns where id = object_id('Tab_CceBionexoPedidoCabecalho') and name in('bit_NaoParticipar'))
	begin
		print 'Criando a(s) coluna(s) (bit_NaoParticipar)'

		

	end
go

/**********************************************************************
		Descrição: 
			
		OBS: ALTER TABLE Tab_TiposMovimentos drop column bit_IntegracaoComCotacao
						
**********************************************************************/

if not exists (select * from sys.tables where name = 'Tab_TiposMovimentos')
	begin
		print 'Criando a tabela Tab_TiposMovimentos'
		
			

	end
go
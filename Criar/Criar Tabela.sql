/**********************************************************************
		Descri��o: 
			
		OBS: 
						
**********************************************************************/

if not exists (select * from sys.tables where name = '<table_name>')
	begin
		print 'Criando Tabela <table_name>'

		/* Colocar c�digo da cria��o da tabela sem o 'Go' no final das instru��es */
		
	end
go
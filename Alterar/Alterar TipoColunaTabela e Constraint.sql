/**********************************************************************
		Descri��o: 
			
		OBS: 
						
**********************************************************************/

if exists (select * from syscolumns where id = object_id('Mov_Estoque') and name in('PercentualComiss�o'))
	begin
		print 'Alterando Tabela Mov_Estoque'

			ALTER TABLE Mov_Estoque
			DROP CONSTRAINT DF_Mov_Estoque_PercentualComiss�o

			ALTER TABLE Mov_Estoque
			ALTER COLUMN PercentualComiss�o FLOAT			

			ALTER TABLE Mov_Estoque
			ADD CONSTRAINT DF_Mov_Estoque_PercentualComiss�o DEFAULT 0 FOR PercentualComiss�o

	end
go
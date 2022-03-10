/**********************************************************************
		Descrição: 
			
		OBS: 
						
**********************************************************************/

if exists (select * from syscolumns where id = object_id('Mov_Estoque') and name in('PercentualComissão'))
	begin
		print 'Alterando Tabela Mov_Estoque'

			ALTER TABLE Mov_Estoque
			DROP CONSTRAINT DF_Mov_Estoque_PercentualComissão

			ALTER TABLE Mov_Estoque
			ALTER COLUMN PercentualComissão FLOAT			

			ALTER TABLE Mov_Estoque
			ADD CONSTRAINT DF_Mov_Estoque_PercentualComissão DEFAULT 0 FOR PercentualComissão

	end
go
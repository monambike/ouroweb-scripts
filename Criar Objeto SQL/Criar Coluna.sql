/**********************************************************************

		Nome da Tabela: <Nome da Tabela, , >

		Nome da Coluna: <Nome da Coluna, , >
						
**********************************************************************/

IF NOT EXISTS (SELECT * FROM SYSCOLUMNS WHERE ID = OBJECT_ID('<Nome da Tabela, , >') AND NAME IN('<Nome da Coluna, , >'))
	BEGIN
		PRINT 'Criando a(s) colunas(s) "<Nome da Coluna, , >"...'

		ALTER TABLE <Nome da Tabela, , > ADD <Nome da Coluna, , >
	END
GO

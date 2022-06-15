/**********************************************************************
		Descri��o: 
			
					
		OBS: 
						
**********************************************************************/

IF EXISTS (SELECT * FROM SYSCOLUMNS WHERE Id = OBJECT_ID ('Tab_Usu�rios') AND NAME IN ('IdMarcaVisualiza'))
	BEGIN
		IF NOT EXISTS (SELECT * FROM SYSCOLUMNS WHERE Id = OBJECT_ID ('Tab_Usu�rios') AND NAME IN ('tmp_IdMarcaVisualiza'))
			BEGIN
				PRINT 'Criando a(s) coluna(s) (tmp_IdMarcaVisualiza)'
		
				ALTER TABLE Tab_Usu�rios ADD tmp_IdMarcaVisualiza INT NULL

			END

		IF EXISTS (SELECT * FROM SYSCOLUMNS WHERE ID = OBJECT_ID ('Tab_Usu�rios') AND NAME IN ('IdMarcaVisualiza'))
			BEGIN
				IF EXISTS (SELECT * FROM SYSCOLUMNS WHERE ID = OBJECT_ID ('Tab_Usu�rios') AND NAME IN ('tmp_IdMarcaVisualiza'))
					BEGIN
						PRINT 'Preenchendo a(s) coluna(s) (tmp_IdMarcaVisualiza)'

						EXEC ('UPDATE Tab_Usu�rios SET tmp_IdMarcaVisualiza = IdMarcaVisualiza WHERE ISNULL(IdMarcaVisualiza, 0) <> 0')

					END	

				PRINT 'Apagando a(s) coluna(s) (IdMarcaVisualiza)'		

				ALTER TABLE Tab_Usu�rios DROP COLUMN IdMarcaVisualiza

			END
	
		IF EXISTS (SELECT * FROM SYSCOLUMNS WHERE ID = OBJECT_ID ('Tab_Usu�rios') AND NAME IN ('tmp_IdMarcaVisualiza'))
			BEGIN
				PRINT 'Alterando a(s) coluna(s) (tmp_IdMarcaVisualiza)'
		
				EXEC SP_RENAME 'Tab_Usu�rios.tmp_IdMarcaVisualiza', 'int_IdMarcaVisualiza', 'COLUMN'

			END
	END		
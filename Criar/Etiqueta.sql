/**********************************************************************
		Descrição: Template para criação de Etiquetas
			
		OBS: 

    SELECT * FROM Tab_Etiqueta
    SELECT * FROM Tab_EtiquetaMod 
    SELECT * FROM tab_ConfigMod
						
**********************************************************************/

BEGIN TRAN
	IF EXISTS (SELECT * FROM Tab_Etiqueta WHERE str_nm_Etiqueta = 'nome_etiqueta')
		BEGIN
			PRINT 'Esta etiqueta ja foi inserida anteriormente no banco'
		END
	ELSE
		BEGIN
			PRINT 'Inserindo etiqueta na tabela Tab_Etiqueta'
			INSERT INTO dbo.Tab_Etiqueta
					( 
						int_nro_Etiqueta ,
					  str_nm_Etiqueta ,
					  fk_int_Empresa ,
					  bit_Ativo ,
					  bit_Default
					)
			select 
				'int_nro_Etiqueta' = -- 74, --> (Inteiro) - Número que vai ser a nova etiqueta
				'str_nm_Etiqueta' = 'nome_etiqueta',
				'int_IdEmpresa' = IdEmpresa,
				'bit_Ativo' = 1,
				'bit_Default' = 0
			from 
				Tab_Empresa
		END

		

IF NOT EXISTS(Select fk_int_ConfigMod, fk_int_Etiqueta From Tab_EtiquetaMod Where fk_int_Etiqueta = (Select Top 1 pk_Etiqueta From Tab_Etiqueta Where str_nm_Etiqueta = '  nome_etiqueta') AND fk_int_ConfigMod = (SELECT pk_int_ConfigMod from tab_ConfigMod where str_NomeMod = 'nome_modulo_etiqueta'))
	Begin 
		INSERT INTO Tab_EtiquetaMod 
									(
										fk_int_ConfigMod,
										fk_int_Etiqueta
									)
									SELECT
									(
										SELECT 
											pk_int_ConfigMod
										from 
											tab_ConfigMod
										where 
											str_NomeMod = 'nome_modulo_etiqueta'
									) pk_int_ConfigMod, pk_Etiqueta 
									FROM
										Tab_Etiqueta
									WHERE
										str_nm_Etiqueta = 'nome_etiqueta'
	End 	
COMMIT TRAN
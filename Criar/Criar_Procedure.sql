/**********************************************************************
		Descrição: 
			
			
		Chamada por:
			

		DataBase: 
		OBS: 
			
			
**********************************************************************/

If Exists (Select * From Sysobjects Where Type = 'p' And name = 'sp_mng_totalvendasvendedor_bonif')
	Begin
		Print 'Removendo Procedure sp_mng_totalvendasvendedor_bonif'
		Drop Procedure sp_mng_totalvendasvendedor_bonif
	End
Go

Print 'Criando Procedure sp_mng_totalvendasvendedor_bonif'
Go
					


Go

Grant Exec On sp_mng_totalvendasvendedor_bonif To Public

Go
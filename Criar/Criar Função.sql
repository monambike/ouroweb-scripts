/******************************************************************************
		Descrição: 
			
            
		Chamada por:
            
			
		DataBase:
		OBS:
			
			SELECT TYPE, * FROM sysobjects WHERE NAME = 'fn_retornaTotalAliquotas'
*******************************************************************************/

if exists (select * from sysobjects where type = 'TF' and name = 'fn_retornaTotalAliquotas')
	begin
		print 'Removendo Function fn_retornaTotalAliquotas'
		drop function fn_retornaTotalAliquotas
	end
go

print 'Criando Function fn_retornaTotalAliquotas'
go



go
select 
	b.NomeDocumento,* 
from 
	Tab_TiposMovimentos a
		inner join 
	Tab_TiposDocumentos b 
		on a.IdTipoDocumento = b.IdTipoDocumento
where 
	b.NomeDocumento like '%MEQ_Ficha Separa��o%'

/*-----------------------------------------*/

select 
	b.NomeDocumento,a.Descri��o, a.IdTipoMovimento, b.IdTipoDocumento 
from 
	Tab_TiposMovimentos a
		inner join 
	Tab_TiposDocumentos b 
			on a.IdTipoDocumento = b.IdTipoDocumento
where 
	b.NomeDocumento like '%Ficha Separa��o%'

select 
	b.NomeDocumento,* 
from 
	Tab_TiposMovimentos a
		inner join 
	Tab_TiposDocumentos b 
		on a.IdTipoDocumento = b.IdTipoDocumento
where 
	b.NomeDocumento like '%MEQ_Ficha Separação%'

/*-----------------------------------------*/

select 
	b.NomeDocumento,a.Descrição, a.IdTipoMovimento, b.IdTipoDocumento 
from 
	Tab_TiposMovimentos a
		inner join 
	Tab_TiposDocumentos b 
			on a.IdTipoDocumento = b.IdTipoDocumento
where 
	b.NomeDocumento like '%Ficha Separação%'

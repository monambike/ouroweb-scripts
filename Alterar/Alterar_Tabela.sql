/**********************************************************************
		Descrição: 
			
		OBS: ALTER TABLE Tab_TiposMovimentos drop column bit_IntegracaoComCotacao
						
**********************************************************************/

if not exists (select * from syscolumns where id = object_id('Tab_TiposMovimentos') and name in('bit_ControlarEntregaTransportadora'))
	begin
		print 'Criando a(s) coluna(s) (bit_ControlarEntregaTransportadora)'
		
			ALTER TABLE dbo.Tab_TiposMovimentos ADD
				bit_ControlarEntregaTransportadora BIT NOT NULL CONSTRAINT DF_Tab_TiposMovimentos_bit_ControlarEntregaTransportadora DEFAULT 0

	end
go
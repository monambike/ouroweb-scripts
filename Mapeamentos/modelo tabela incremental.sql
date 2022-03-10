/**********************************************************************
		Descrição: 
			
		OBS: DROP TABLE Tab_Moedas_Simbolos
						
**********************************************************************/

if not exists (select * from sys.tables where name = 'Tab_Moedas_Simbolos')
	begin
		print 'Criando Tabela Tab_Moedas_Simbolos'

		CREATE TABLE dbo.Tab_Moedas_Simbolos
			(
				pk_int_SimboloMoeda int NOT NULL IDENTITY (1, 1),
				str_Simbolo varchar(4) NULL,
				str_DescricaoSimbolo varchar(200) NULL,
				bit_Ativo bit NOT NULL
			)  ON [PRIMARY]

		ALTER TABLE dbo.Tab_Moedas_Simbolos ADD CONSTRAINT
			DF_Tab_Moedas_Simbolos_bit_Ativo DEFAULT 0 FOR bit_Ativo

		ALTER TABLE dbo.Tab_Moedas_Simbolos ADD CONSTRAINT
			PK_Tab_Moedas_Simbolos_1 PRIMARY KEY NONCLUSTERED 
			(
			pk_int_SimboloMoeda
			) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		
	end
go
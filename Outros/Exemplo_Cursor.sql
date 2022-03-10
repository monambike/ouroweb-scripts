/******************************************************************************
		Descrição: 
			
            
		Chamada por:
            

		DataBase:
		OBS:
			
			
*******************************************************************************/

if exists (select * from sysobjects where type IN ('TF','FN') and name = 'fn_lst_NumeroDocumentoPorGrupoPagamento')
	begin
		print 'Removendo Function fn_lst_NumeroDocumentoPorGrupoPagamento'
		drop function fn_lst_NumeroDocumentoPorGrupoPagamento
	end
go

print 'Criando Function fn_lst_NumeroDocumentoPorGrupoPagamento'
go

CREATE FUNCTION fn_lst_NumeroDocumentoPorGrupoPagamento
								(
									@int_NroGrupo AS INT = 0
								)

RETURNS VARCHAR(8000)

AS

	BEGIN

		DECLARE @str_NumeroDocumentoConcatenados varchar(2000)
		DECLARE @str_NumeroDocumento varchar(30)

		DECLARE db_cursor CURSOR FOR  
		
		SELECT 
			a.NúmeroDocumento
		FROM 
			Mov_Financeiro AS a WITH(NOLOCK) 
		WHERE 
			a.NroGrupo = @int_NroGrupo AND 
			a.GrupoPagamento = 1

		OPEN db_cursor   
		FETCH NEXT FROM db_cursor INTO @str_NumeroDocumento

		WHILE @@FETCH_STATUS = 0   
			BEGIN   
				SET @str_NumeroDocumentoConcatenados = ISNULL(@str_NumeroDocumentoConcatenados, '') + ISNULL(@str_NumeroDocumento, '') + ' '

			FETCH NEXT FROM db_cursor INTO @str_NumeroDocumento

		END   

		CLOSE db_cursor   
		DEALLOCATE db_cursor
		
		RETURN @str_NumeroDocumentoConcatenados

	END
GO
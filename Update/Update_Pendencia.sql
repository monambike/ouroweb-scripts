BEGIN TRAN; 
    
UPDATE 
		Tab_Cadastro
SET
		bit_bloqueiacomprasemcredito = '0'
WHERE
		ISNULL(Tab_Cadastro.Cr�ditoAVencer,0)= 0;    

IF ( @@ERROR <> 0 ) 
    BEGIN
        PRINT 'Erro ao realizar o Update 4 na Tab_Cadastro' ;
        ROLLBACK TRAN ;
        PRINT 'Transa��o interrompida'
    END ;
ELSE 
    BEGIN 
        PRINT 'Update 4 na Tab_Cadastro Realizado sem erros';
		COMMIT TRAN;
		PRINT '----Transa��o conclu�da sem erros----'
    END;
GO
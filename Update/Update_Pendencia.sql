BEGIN TRAN; 
    
UPDATE 
		Tab_Cadastro
SET
		bit_bloqueiacomprasemcredito = '0'
WHERE
		ISNULL(Tab_Cadastro.CréditoAVencer,0)= 0;    

IF ( @@ERROR <> 0 ) 
    BEGIN
        PRINT 'Erro ao realizar o Update 4 na Tab_Cadastro' ;
        ROLLBACK TRAN ;
        PRINT 'Transação interrompida'
    END ;
ELSE 
    BEGIN 
        PRINT 'Update 4 na Tab_Cadastro Realizado sem erros';
		COMMIT TRAN;
		PRINT '----Transação concluída sem erros----'
    END;
GO
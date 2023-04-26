/*
alter database [msdb] set read_only with rollback immediate
go
alter database [msdb] set read_write with rollback immediate
go
disconnect everyone*/

/* Esse job seria rodado todos os dias úteis no período da manhã */

/*

good posts:
https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sysmail-help-queue-sp-transact-sql?view=sql-server-ver16#result-set
https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-send-dbmail-transact-sql?redirectedfrom=MSDN&view=sql-server-ver16
https://www.codeproject.com/Articles/485124/Configuring-Database-Mail-in-SQL-Server

Common Errors At E-mail Sending:
https://learn.microsoft.com/pt-br/sql/relational-databases/database-mail/database-mail-general-troubleshooting?view=sql-server-ver16
Enable Gmail for SMTP:
https://help.accredible.com/smtp-setup-in-gmail-inbox
Other problems:
https://serversmtp.com/cannot-send-emails/
https://kinsta.com/blog/gmail-smtp-server/


/* WARNING! FOLLOWING CODE SNIPPET ALLOWS SERVER SENDING ON CURRENT SERVER */
No SQL Server Management Studio, conecte-se a uma instância do SQL Server usando uma janela do editor de consulta e então execute o seguinte código:
sp_configure 'show advanced', 1; 
GO
RECONFIGURE;
GO
sp_configure;
GO
Se você decidir que é apropriado habilitar Database Mail, execute o seguinte código:
sp_configure 'Database Mail XPs', 1; 
GO
RECONFIGURE;
GO
Para restaurar o procedimento sp_configure para seu estado padrão, que não mostra opções avançadas, execute o seguinte código:
sp_configure 'show advanced', 0; 
GO
RECONFIGURE;
GO

/* Enable service broker in the MSDB database */
USE [master]
GO
ALTER DATABASE [MSDB] SET  ENABLE_BROKER WITH NO_WAIT
GO


USE [msdb]
GO
/* Execute the following statement in the msdb database to check the status of the mail queue */
EXEC msdb.dbo.sysmail_help_queue_sp @queue_type = 'Mail';
/* Step1: Varifying the new profile */
SELECT * FROM sysmail_profile
/* Step2: Verifying accounts */
SELECT * FROM sysmail_account
/* Step3: To check the accounts of a profile */
SELECT * FROM sysmail_profileaccount
/* Step4: To display mail server details */
SELECT * FROM sysmail_server


exec msdb.sysmail_stop_sp
go
exec msdb.sysmail_start_sp
go

*/

USE msdb
GO

CREATE TABLE [Contact]
(
  [ContactId] INT PRIMARY KEY IDENTITY(1,1)
, [Name]      VARCHAR(MAX)
, [Email]     VARCHAR(MAX)
, [CakeDate]  DATE
, [Status]    VARCHAR(MAX) CHECK ([Status] IN ('Pending', 'Paid', 'Unpaid')) 
)

/*ENVIAR EMAIL*/
/* Select all contacts owing a cake 🍰 */
DECLARE @CurrentContactId BIGINT, @MaxId BIGINT
SELECT @CurrentContactId=MIN([ContactId]), @MaxId=MAX([ContactId]) FROM [Contact] WHERE [Status] = 'Pending'
/* For each selected contact send one e-mail according its status */
WHILE @CurrentContactId <= @MaxId
BEGIN
  DECLARE @TodayDate AS DATE = CAST(GETDATE() AS DATE)
  /* Getting contact e-mail and cake date */
  DECLARE @Email AS VARCHAR(MAX), @CakeDate AS DATE
  SELECT @Email = [Email], @CakeDate = [CakeDate] FROM [Contact]
  /* Declaring sender as myself for testing purposes */
  SET @Email = 'dvp10@ouroweb.com.br'

  /* Making e-mail body */
  DECLARE @DaysRemaining AS INT = DATEDIFF(DAY, @TodayDate, @CakeDate)
  DECLARE @EmailBody AS VARCHAR(MAX) = '<h1>Olá! Esse é o email da <b>Fila do Bolo<b>.</h1>'
  SELECT
    @EmailBody +=
      CASE
        WHEN @DaysRemaining < 5 THEN 'Você terá que pagar o bolo em <b>' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</b> dias.'
        WHEN @DaysRemaining = 0 THEN 'Lembrou de trazer o bolo? Você terá que pagar o bolo <b>hoje</b>.'
        WHEN @DaysRemaining < 0 THEN 'A data pro pagamento do bolo passou 😠😡 CADE O BOLO? Já fazem <b>' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</b> dias que você está em atraso!'
        ELSE ''
      END
  DECLARE @PlanilhaDoBoloPath AS VARCHAR(MAX) = ''
  SET @EmailBody +=  CHAR(13) + CHAR(10) + 'Você pode ver a planilha do bolo aqui: "' + @PlanilhaDoBoloPath + '". Seu pilantra... 🙄'

  EXEC sp_send_dbmail
    @profile_name = 'SQL Profile'
  , @Recipients   = @Email
  , @Subject      = 'Pagamento do Bolo 🍰'
  , @Body         = @EmailBody

  SELECT @CurrentContactId = MIN([ContactId]) FROM [Contact] where [ContactId] > @CurrentContactId
END

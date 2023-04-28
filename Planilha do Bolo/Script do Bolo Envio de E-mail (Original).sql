/**************************************************************************************

  ===================================================================================
   Script Short Description
  ===================================================================================

  This Script was created to send an email to someone who owes a cake at OuroWeb.

  We have a spreadsheet where we do the control, a macro was created so that when the
  spreadsheet was saved a copy was created in a CSV file.

  This copy is read by this Script, its data is polished, and then the e-mail is sent
  according to the date and status of the contact list.

  ===================================================================================
   Execution
  ===================================================================================

  EXEC [msdb].[dbo].[SendEmailPlanilhaDoBolo]

  ===================================================================================
   Spreadsheet File
  ===================================================================================

  The file is in the same folder as this Script.

  ===================================================================================
   Copy Of The Code From The Spreadsheet
  ===================================================================================

  Option Explicit

  Private Sub Workbook_Open()
    Application.EnableEvents = True
  End Sub

  Private Sub Workbook_BeforeSave(ByVal SaveAsUI As Boolean, Cancel As Boolean)
    Call ExportWorksheetAndSaveAsCSV
  End Sub

  Public Sub ExportWorksheetAndSaveAsCSV()

    Dim wbkExport As Workbook
    Dim shtToExport As Worksheet

    Set shtToExport = ThisWorkbook.Worksheets("Sheet1")     'Sheet to export as CSV
    Set wbkExport = Application.Workbooks.Add
    shtToExport.Copy Before:=wbkExport.Worksheets(wbkExport.Worksheets.Count)
    Application.DisplayAlerts = False                       'Possibly overwrite without asking
    
    Dim CsvFileName As String
    CsvFileName = Replace(ThisWorkbook.FullName, ".xlsm", ".csv")
  
    wbkExport.SaveAs Filename:=CsvFileName, FileFormat:=xlCSV
    Application.DisplayAlerts = True
    wbkExport.Close SaveChanges:=False
  End Sub

**************************************************************************************/

USE [msdb]
GO

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'P' AND NAME = 'SendEmailPlanilhaDoBolo')
  BEGIN
    PRINT 'Removendo procedure "[SendEmailPlanilhaDoBolo]"...'
    DROP PROCEDURE [dbo].[SendEmailPlanilhaDoBolo]
  END
GO

PRINT 'Criando procedure "[SendEmailPlanilhaDoBolo]"...'
GO

CREATE PROCEDURE [dbo].[SendEmailPlanilhaDoBolo]
WITH ENCRYPTION
AS
BEGIN
  SET NOCOUNT ON

  /* SETTINGS */
  /* Spreadsheets' paths */
  DECLARE
  /* Spreadsheet with macro that generates CSV file */
  @PlanilhaDoBoloWithMacroXLSMPath AS VARCHAR(MAX) = 'C:\TMP\MarcosTemp\PlanilhaBolo2023.xlsm'
  /* Spreadsheet where data is updated */
, @PlanilhaDoBoloOriginalCSVPath   AS VARCHAR(MAX) = 'C:\TMP\MarcosTemp\PlanilhaBolo2023.csv'
  /* Spreadsheet without macro where end user can access */
, @PlanilhaDoBoloEndUserXLSXPath   AS VARCHAR(MAX) = 'C:\TMP\PlanilhaBolo2023.xlsx'
  /* E-mails */
  DECLARE
  @ViniciusEmail AS VARCHAR(MAX) = 'dvp10@ouroweb.com.br'
, @MarcosEmail   AS VARCHAR(MAX) = 'dvp07@ouroweb.com.br'
  DECLARE @ViniciusEMarcosEmail AS VARCHAR(MAX) = @ViniciusEmail + ';' + @MarcosEmail

  /* READING CSV FILE WITH RAW CONTENT FROM CONTACT LIST */
  /* Creates temporary table for having excel content */
  IF OBJECT_ID('tempdb..#ExcelContent') IS NOT NULL
    DROP TABLE #ExcelContent
  CREATE TABLE #ExcelContent([Name] VARCHAR(MAX), [Email] VARCHAR(MAX), [Status] VARCHAR(MAX), [CakeDate] VARCHAR(MAX), [RemainingContent] VARCHAR(MAX));
  /* Runs command for reading csv into temporary table */
  DECLARE @BulkInsertCommand NVARCHAR(MAX)
  SET @BulkInsertCommand = N'BULK INSERT #ExcelContent FROM '''+@PlanilhaDoBoloOriginalCSVPath+''' WITH (FIRSTROW = 5, CODEPAGE = ''1252'', FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'');'
  EXEC(@BulkInsertCommand)
  
  /* TRANSFERING CSV DATA TO TABLE */
  /* Creating contact list table for having polished data */
  DECLARE @Contact TABLE 
  (
    [ContactId] INT PRIMARY KEY IDENTITY(1,1)
  , [Name]      VARCHAR(MAX)
  , [Email]     VARCHAR(MAX)
  , [Status]    VARCHAR(MAX)
  , [CakeDate]  DATE
  )
  /* Transfering polished data for created table */
  INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT [Name], [Email], CONVERT(DATE, [CakeDate], 103), [Status] FROM #ExcelContent
  SELECT * FROM @Contact
  SELECT * FROM #ExcelContent

  /* For testing all email templates */
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Vinícius Gabriel' AS [Name], @ViniciusEmail AS [Email], CONVERT(DATE, GETDATE()-2, 103) AS [CakeDate], 'EM DÉBITO' AS [Status]
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Vinícius Gabriel' AS [Name], @ViniciusEmail AS [Email], CONVERT(DATE, GETDATE()  , 103) AS [CakeDate], 'EM DÉBITO' AS [Status]
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Vinícius Gabriel' AS [Name], @ViniciusEmail AS [Email], CONVERT(DATE, GETDATE()+2, 103) AS [CakeDate], 'EM DÉBITO' AS [Status]
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Marcos Roberto' AS [Name], @MarcosEmail AS [Email], CONVERT(DATE, GETDATE()-2, 103) AS [CakeDate], 'EM DÉBITO' AS [Status]
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Marcos Roberto' AS [Name], @MarcosEmail AS [Email], CONVERT(DATE, GETDATE()  , 103) AS [CakeDate], 'EM DÉBITO' AS [Status]
  --INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT 'Marcos Roberto' AS [Name], @MarcosEmail AS [Email], CONVERT(DATE, GETDATE()+2, 103) AS [CakeDate], 'EM DÉBITO' AS [Status]

  /* Creating variables for saving info of list of contacts that are
  owing a cake */
  DECLARE @ContactInDebtList AS VARCHAR(MAX) = '', @EmailSentContactCount AS INT = 0
  
  /* SENDING EMAIL FOR CONTACT IN DEBT WITH CAKE */
  /* Select all contacts that are owing a cake 🍰 */
  DECLARE @CurrentContactInDebtId BIGINT, @MaxId BIGINT
  SELECT @CurrentContactInDebtId=MIN([ContactId]), @MaxId=MAX([ContactId]) FROM @Contact WHERE UPPER([Status]) = 'EM DÉBITO'
  DECLARE @TodayDate AS DATE = CAST(GETDATE() AS DATE)
  /* For each contact in debt, sends one e-mail according its status */
  WHILE @CurrentContactInDebtId <= @MaxId
  BEGIN
    /* Getting contact e-mail and cake date */
    DECLARE @ContactInDebtFirstName AS VARCHAR(MAX), @ContactInDebtEmail AS VARCHAR(MAX), @ContactInDebtCakeDate AS DATE, @ContactInDebtStatus AS VARCHAR(MAX)
    SELECT
      @ContactInDebtFirstName = (SELECT CASE CHARINDEX(' ', [Name], 1) WHEN 0 THEN [Name] /* Empty or single word */ ELSE SUBSTRING([Name], 1, CHARINDEX(' ', [Name], 1) - 1) /* Multi-word */ END)
    , @ContactInDebtEmail     = [Email]
    , @ContactInDebtCakeDate  = [CakeDate]
    , @ContactInDebtStatus    = [Status]
    FROM @Contact WHERE [ContactId] = @CurrentContactInDebtId
    
    /* Getting date diff from cake date to today's date */
    DECLARE @DaysRemaining AS INT = DATEDIFF(DAY, @TodayDate, @ContactInDebtCakeDate)
    /* Just send the e-mail on following conditions:
    1 - Two days before Cake Payment Day
    2 - Current day for Cake Payment Day
    3 - When late for Cake Payment Day is sent everyday */
    DECLARE @TwoDaysBeforeCakeDay AS BIT = (SELECT CASE WHEN @DaysRemaining = 2 THEN 1 ELSE 0 END)
    DECLARE @AtTheCakeDay         AS BIT = (SELECT CASE WHEN @DaysRemaining = 0 THEN 1 ELSE 0 END)
    DECLARE @AfterCakeDayDate     AS BIT = (SELECT CASE WHEN @DaysRemaining < 0 THEN 1 ELSE 0 END)
    IF UPPER(@ContactInDebtStatus) = 'EM DÉBITO' AND (@TwoDaysBeforeCakeDay = 1 OR @AtTheCakeDay = 1 OR @AfterCakeDayDate = 1)
      BEGIN
        /* Making e-mail body */
        DECLARE @EmailBodyForContactInDebt AS VARCHAR(MAX) =
          '<h1>Olá! Bom dia <b><font color="#333333">' + @ContactInDebtFirstName + '</font></b>. Esse é o email da <b>Fila do Bolo</b> &#127874;</h1>'
          + CHAR(13) + CHAR(10)
          + CHAR(13) + CHAR(10) + 'Estamos aqui pra lembrar da sua situação, na qual...'
          + CHAR(13) + CHAR(10)
          + CHAR(13) + CHAR(10)

        /* Warning about how many days are remaining */
        SELECT
          @EmailBodyForContactInDebt +=
            CASE
              WHEN @TwoDaysBeforeCakeDay = 1 THEN '<h2>Você terá que pagar o bolo em <b><font color="#ffff00">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias. &#8986;</h2>'
              WHEN @AtTheCakeDay         = 1 THEN '<h2>Perguntamos. Lembrou de trazer o bolo? Você terá que pagar o bolo <b><font color="#ff6600">hoje! &#128064; </font></h2>'
              WHEN @AfterCakeDayDate     = 1 THEN '<h2>A data pro pagamento do bolo passou &#128544;&#128544; CADE O BOLO? Já fazem <b><font color="#ff0000">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias que você está em atraso caloteiro!</h2>'
              ELSE ''
            END
        SET @EmailBodyForContactInDebt += 
          CHAR(13) + CHAR(10) + '<p><i><font color="#333333">Lembrando que para pedir você pode ligar ou falar no whatsapp com a Casa dos Bolos <a href="+55 16 98809-9251"></a>. '
                              + 'Se quiser pode pedir em outro lugar ou trazer o bolo de casa também.</font></i></p>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + '<p>Em questão de sabores, é sempre bem vindo o <font color="#7a00cc">Nacional Cenoura com Cobertura de Chocolate</font>. &#128526; E se possível pedir por volta do <b>período da manhã</b>, de preferência as <b>10:30</b>!</p>'
        + CHAR(13) + CHAR(10)
        /* CSS Cake Layers - ChatGPT made it ❤ */
        + CHAR(13) + CHAR(10) + '<div style="width: 120px; height: 50px; border-radius: 5px; margin: 0 auto; background-color: #c266ff; box-shadow: 5px 5px 10px #999;"></div>'
        + CHAR(13) + CHAR(10) + '<div style="width: 140px; height: 50px; border-radius: 10px; margin: 0 auto; background-color: #c24df8; box-shadow: 5px 5px 10px #999;"></div>'
        + CHAR(13) + CHAR(10) + '<div style="width: 160px; height: 50px; border-radius: 15px; margin: 0 auto; background-color: #9f27fa; box-shadow: 5px 5px 10px #999;"></div>'
        + CHAR(13) + CHAR(10) + '<div style="width: 180px; height: 50px; border-radius: 20px; margin: 0 auto; background-color: #7a00cc; box-shadow: 5px 5px 10px #999;"></div>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + '<p>Se você quiser ver tabela de preços e como está o andamento da fila, você pode ver a planilha do bolo'
        + CHAR(13) + CHAR(10) + 'aqui na <a href="' + @PlanilhaDoBoloEndUserXLSXPath + '">planilha do bolo</a> ou no anexo.</p>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + '<p>&#128580; bolo...</p>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + '<p>Caso você ache que tenha recebido esse e-mail por engano, por favor <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">clique aqui e converse com a fila do bolo</a>.</p>'
        /* Places html and body tag at end and beggining of email body */
        SET @EmailBodyForContactInDebt = '<html><body>' + @EmailBodyForContactInDebt + '</body></html>'

        
        /* Sending e-mail for contact in debt */
        DECLARE @HappyCakeImage VARCHAR(MAX) = 'C:\TMP\FiladoBolo\bolo_pulando_feliz.png'
        BEGIN TRY
          DECLARE @FileAttachmentsForContactInDebt VARCHAR(MAX) = @PlanilhaDoBoloEndUserXLSXPath + ';' + @HappyCakeImage
          EXEC sp_send_dbmail
            @profile_name     = 'SQL Profile'
          , @Recipients       = @ContactInDebtEmail
          , @Subject          = 'Aviso do Pagamento do Bolo!'
          , @Body             = @EmailBodyForContactInDebt
          , @Body_Format      = 'HTML'
          , @file_attachments = @FileAttachmentsForContactInDebt
        END TRY
        BEGIN CATCH
          /* If not possible send an e-mail because attachment is in use, sends
          the e-mail without attachment */
          IF ERROR_NUMBER() = 22051 AND ERROR_MESSAGE() LIKE '%Executing API ''CreateFile'' failed with error number 32%'
            BEGIN
              EXEC sp_send_dbmail
                @profile_name     = 'SQL Profile'
              , @Recipients       = @ContactInDebtEmail
              , @Subject          = 'Aviso do Pagamento do Bolo!'
              , @Body             = @EmailBodyForContactInDebt
              , @Body_Format      = 'HTML'
              PRINT 'O arquivo da planilha do bolo está aberto por outro usuário e o e-mail foi enviado sem anexos.'
            END
        END CATCH
        PRINT 'Enviado e-mail para "' + @ContactInDebtFirstName + '" com endereço "' + @ContactInDebtEmail + '"!'
        PRINT CHAR(13) + CHAR(10)

        /* Adds this contact at contact in deb list for warning Cake Line managers
        that e-mail was sent for this contact */
        SET @ContactInDebtList += '<ul style="list-style-type: none;">'
                                  + '<li>&#9997; <b>Nome:</b> ' + @ContactInDebtFirstName + '</li>'
                                  + '<li>&#128231; </b>Email:</b> ' +  @ContactInDebtEmail + ';</li>'
                                + '</ul>'
        SET @EmailSentContactCount += 1
      END
    SELECT @CurrentContactInDebtId = MIN([ContactId]) FROM @Contact where [ContactId] > @CurrentContactInDebtId
  END

  /* SENDING EMAIL FOR CAKE LINE MANAGERS */
  /* Only sends email for Cake Line managers if an e-mail were sent
  for an user in contact list in debt*/
  IF @EmailSentContactCount > 0
    BEGIN
      /* Coloca plural se tiver mais de um contato para quem
      foi enviado o e-mail */
      DECLARE @Plural AS VARCHAR(MAX) = ''
      IF @EmailSentContactCount > 1 SET @Plural = 's'

      DECLARE @EmailBodySendingInfo AS VARCHAR(MAX) =
        '<h1>Relatório da Fila do Bolo &#128234;</h1>'
      + '<h2>Foi enviado e-mail da fila do bolo para ' + CAST(@EmailSentContactCount AS VARCHAR(MAX)) + ' contato'+@Plural+' listado'+@Plural+' abaixo. &#128071;</h2>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + @ContactInDebtList
      + CHAR(13) + CHAR(10) + '<p><a href="' + @PlanilhaDoBoloWithMacroXLSMPath + '">Clique aqui</a> para gerenciar os e-mails da planilha do bolo.</p>'
      
      /* Places html and body tag at end and beggining of email body */
      SET @EmailBodySendingInfo = '<html><body>' + @EmailBodySendingInfo + '</body></html>'
      /* Sending e-mail for contact in debt */
      DECLARE @FileAttachmentsForCakeLineManager VARCHAR(MAX) = @PlanilhaDoBoloEndUserXLSXPath
      /* Sending email for Cake Line managers */
      EXEC sp_send_dbmail
        @profile_name = 'SQL Profile'
      , @Recipients   = @ViniciusEMarcosEmail
      , @Subject      = 'Lista de E-mails Enviados Hoje'
      , @Body         = @EmailBodySendingInfo
      , @Body_Format  = 'HTML'

      PRINT 'Foi enviado um e-mail para quem gerencia a fila do bolo.'
      + CHAR(13) + CHAR(10) + 
      + CHAR(13) + CHAR(10) + 
      + 'Foi enviado o e-mail para ' + CAST(@EmailSentContactCount AS VARCHAR(MAX)) + ' contato'+@Plural+' e os gerentes da fila do bolo.'
      + CHAR(13) + CHAR(10) + 'Por favor, lembre que apesar dos e-mails terem sido enviados eles podem não chegar ao destinatários se houver algum problema no meio do caminho, como Spam por exemplo.'
    END
  ELSE PRINT 'Não foi enviado nenhum e-mail pois não há contatos em débito ou hoje não é um dia útil.'
END

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

SET NOCOUNT ON
USE msdb
GO

/* SETTINGS */
DECLARE
  @PlanilhaDoBoloOriginalPath AS VARCHAR(MAX) = 'C:\TMP\PlanilhaBolo2023.csv'
, @PlanilhaDoBoloBackupPath AS VARCHAR(MAX) = 'C:\TMP\PlanilhaBolo2023.xlsm'

/* READS CSV FILE WITH RAW CONTENT FROM CONTACT LIST */
IF OBJECT_ID('tempdb..#ExcelContent') IS NOT NULL DROP TABLE #ExcelContent
CREATE TABLE #ExcelContent([Name] VARCHAR(MAX), [Email] VARCHAR(MAX), [Status] VARCHAR(MAX), [CakeDate] VARCHAR(MAX), [RemainingContent] VARCHAR(MAX));
DECLARE @BulkInsertCommand NVARCHAR(MAX)
SET @BulkInsertCommand = N'BULK INSERT #ExcelContent FROM '''+@PlanilhaDoBoloOriginalPath+''' WITH (FIRSTROW = 5, CODEPAGE = ''1252'', FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'');'
EXEC(@BulkInsertCommand)

/* TRANSFERING CSV CONTENT TO POLISHED CONTACT LIST */
DECLARE @Contact TABLE 
(
  [ContactId] INT PRIMARY KEY IDENTITY(1,1)
, [Name]      VARCHAR(MAX)
, [Email]     VARCHAR(MAX)
, [Status]    VARCHAR(MAX)
, [CakeDate]  DATE
)
INSERT INTO @Contact ([Name], [Email], [CakeDate], [Status]) SELECT [Name], [Email], CONVERT(date, [CakeDate], 103), [Status] FROM #ExcelContent
SELECT * FROM @Contact
SELECT * FROM #ExcelContent

--INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE()-2, 'Pending')
--INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE(),   'Pending')
--INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE()+2, 'Pending')

/* SEND EMAIL FOR CONTACT LIST THAT IS IN DEBT WITH CAKE */
/* Select all contacts owing a cake 🍰 */
DECLARE @CurrentContactId BIGINT, @MaxId BIGINT
SELECT @CurrentContactId=MIN([ContactId]), @MaxId=MAX([ContactId]) FROM @Contact WHERE [Status] = 'EM DÉBITO'
DECLARE @TodayDate AS DATE = CAST(GETDATE() AS DATE)
/* Saving list of contacts that are owing a cake */
DECLARE @ContactInDebtList AS VARCHAR(MAX) = '', @EmailSentContactCount AS INT = 0
/* For each selected contact send one e-mail according its status */
WHILE @CurrentContactId <= @MaxId
BEGIN
  /* Getting contact e-mail and cake date */
  DECLARE @FirstName AS VARCHAR(MAX), @Email AS VARCHAR(MAX), @CakeDate AS DATE, @Status AS VARCHAR(MAX)
  SELECT
    @FirstName = (SELECT CASE CHARINDEX(' ', [Name], 1) WHEN 0 THEN [Name] /* Empty or single word */ ELSE SUBSTRING([Name], 1, CHARINDEX(' ', [Name], 1) - 1) /* Multi-word */ END)
  , @Email     = [Email]
  , @CakeDate  = [CakeDate]
  , @Status    = [Status]
  FROM @Contact WHERE [ContactId] = @CurrentContactId

  IF @Status = 'EM DÉBITO'
    BEGIN
      /* Making e-mail body */
      DECLARE @EmailBodyContactInDebt AS VARCHAR(MAX) =
        '<h1>Olá! Bom dia <b><font color="#333333">' + @FirstName + '</font></b>. Esse é o email da <b>Fila do Bolo</b> &#127874;</h1>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + 'Estamos aqui pra lembrar da sua situação, na qual...'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10)
        
      /* Getting date diff from cake date to today's date */
      DECLARE @DaysRemaining AS INT = DATEDIFF(DAY, @CakeDate, @TodayDate)
      SELECT
        @EmailBodyContactInDebt +=
          CASE
            WHEN @DaysRemaining = 2 THEN '<h2>Você terá que pagar o bolo em <b><font color="#ffff00">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias.</h2>'
            WHEN @DaysRemaining = 0 THEN '<h2>Perguntamos. Lembrou de trazer o bolo? Você terá que pagar o bolo <b><font color="#ff6600">hoje!</font></h2>'
            WHEN @DaysRemaining < 0 THEN '<h2>A data pro pagamento do bolo passou &#128544;&#128544; CADE O BOLO? Já fazem <b><font color="#ff0000">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias que você está em atraso pilantra!</h2>'
            ELSE ''
          END
      SET @EmailBodyContactInDebt += 
        CHAR(13) + CHAR(10) + '<p><i><font color="#333333">Lembrando que para pedir você pode ligar ou falar no whatsapp com a Casa dos Bolos <a href="+55 16 98809-9251"></a>. '
                            + 'Se quiser pode pedir em outro lugar ou trazer o bolo de casa também.</font></i></p>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Em questão de sabores, é sempre bem vindo o <font color="#7a00cc">Nacional Cenoura com Cobertura de Chocolate</font>. &#128526;</p>'
      + CHAR(13) + CHAR(10)
      /* CSS Cake Layers */
      + CHAR(13) + CHAR(10) + '<div style="width: 120px; height: 50px; border-radius: 5px; margin: 0 auto; background-color: #c266ff; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 140px; height: 50px; border-radius: 10px; margin: 0 auto; background-color: #c24df8; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 160px; height: 50px; border-radius: 15px; margin: 0 auto; background-color: #9f27fa; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 180px; height: 50px; border-radius: 20px; margin: 0 auto; background-color: #7a00cc; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Se você quiser ver tabela de preços e como está o andamento da fila, você pode ver a planilha do bolo'
      + CHAR(13) + CHAR(10) + 'aqui na <a href="' + @PlanilhaDoBoloBackupPath + '">planilha do bolo</a> ou no anexo.</p>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Seu <b>PILANTRA</b>... &#128580;</p>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Caso você ache que tenha recebido esse e-mail por engano, favor <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">contatar a fila do bolo</a>.</p>'

      SET @EmailBodyContactInDebt = '<html><body>' + @EmailBodyContactInDebt + '</body></html>'

      DECLARE @FileAttachments VARCHAR(MAX) = @PlanilhaDoBoloBackupPath + ';C:\TMP\FiladoBolo\bolo_pulando_feliz.png'
      EXEC sp_send_dbmail
        @profile_name     = 'SQL Profile'
      , @Recipients       = @Email
      , @Subject          = 'Pagamento do Bolo!!'
      , @Body             = @EmailBodyContactInDebt
      , @Body_Format      = 'HTML'
      , @file_attachments = @FileAttachments
      PRINT 'Enviado e-mail para "' + @FirstName + '" com endereço "' + @Email + '"!'

      SET @ContactInDebtList += '&#9997; Nome: ' + @FirstName + CHAR(13) + CHAR(10) + '&#9993; Email: ' +  @Email + ';' + CHAR(13) + CHAR(10) +  + CHAR(13) + CHAR(10)
      SET @EmailSentContactCount += 1
    END
  SELECT @CurrentContactId = MIN([ContactId]) FROM @Contact where [ContactId] > @CurrentContactId
END

/* SENDS AN EMAIL FOR CAKE LIST MANAGERS */
IF @EmailSentContactCount > 0
  BEGIN
    /* Coloca plural se tiver mais de um contato para quem
    foi enviado o e-mail */
    DECLARE @Plural AS VARCHAR(MAX) = ''
    IF @EmailSentContactCount > 1 SET @Plural = 's'

    DECLARE @EmailBodySendingInfo AS VARCHAR(MAX) =
      '<p>Foi enviado e-mail da fila do bolo para ' + CAST(@EmailSentContactCount AS VARCHAR(MAX)) + ' contato'+@Plural+' listado'+@Plural+' abaixo:<p>'
    + CHAR(13) + CHAR(10)
    + CHAR(13) + CHAR(10) + @ContactInDebtList

    DECLARE @ViniciusEmail AS VARCHAR(MAX) = 'dvp10@ouroweb.com.br', @MarcosEmail VARCHAR(MAX) = 'dvp07@ouroweb.com.br'
    DECLARE @ViniciusEMarcosEmail AS VARCHAR(MAX) = @ViniciusEmail + ',' + @MarcosEmail
    EXEC sp_send_dbmail
      @profile_name     = 'SQL Profile'
    --, @Recipients       = @ViniciusEMarcosEmail
    , @Recipients       = @ViniciusEmail
    , @Subject          = 'Lista de E-mails Enviados'
    , @Body             = @EmailBodySendingInfo
    , @Body_Format      = 'HTML'

    PRINT 'Foi enviado o e-mail para ' + CAST(@EmailSentContactCount AS VARCHAR(MAX)) + ' contato'+@Plural+' e também foi enviado um e-mail para quem gerencia a fila do bolo.'
  END
ELSE PRINT 'Não foi enviado nenhum e-mail pois não há contatos em débito.'

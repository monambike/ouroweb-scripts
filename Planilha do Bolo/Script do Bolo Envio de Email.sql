USE msdb
GO

DECLARE @Contact TABLE 
(
  [ContactId] INT PRIMARY KEY IDENTITY(1,1)
, [Name]      VARCHAR(MAX)
, [Email]     VARCHAR(MAX)
, [CakeDate]  DATE
, [Status]    VARCHAR(MAX) CHECK ([Status] IN ('Pending', 'Paid', 'Unpaid')) 
)

INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE()-2, 'Pending')
INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE(),   'Pending')
INSERT INTO @Contact VALUES ('Vinícius Gabriel', 'dvp10@ouroweb.com.br', GETDATE()+2, 'Pending')

/*ENVIAR EMAIL*/
/* Select all contacts owing a cake 🍰 */
DECLARE @CurrentContactId BIGINT, @MaxId BIGINT
SELECT @CurrentContactId=MIN([ContactId]), @MaxId=MAX([ContactId]) FROM @Contact WHERE [Status] = 'Pending'
DECLARE @TodayDate AS DATE = CAST(GETDATE() AS DATE)
/* For each selected contact send one e-mail according its status */
WHILE @CurrentContactId <= @MaxId
BEGIN
  /* Getting contact e-mail and cake date */
  DECLARE @FirstName AS VARCHAR(MAX), @Email AS VARCHAR(MAX), @CakeDate AS DATE
  SELECT
    @FirstName = (SELECT CASE CHARINDEX(' ', [Name], 1) WHEN 0 THEN [Name] /* Empty or single word */ ELSE SUBSTRING([Name], 1, CHARINDEX(' ', [Name], 1) - 1) /* Multi-word */ END)
  , @Email     = [Email]
  , @CakeDate  = [CakeDate]
  FROM @Contact WHERE [ContactId] = @CurrentContactId

  /* Getting date diff from cake date to today's date */
  DECLARE @DaysRemaining AS INT = DATEDIFF(DAY, @CakeDate, @TodayDate)
  
  IF @DaysRemaining <= 5
    BEGIN
      /* Making e-mail body */
      DECLARE @EmailBody AS VARCHAR(MAX) =
        '<h1>Olá! Bom dia  Esse é o email da <b>Fila do Bolo</b> &#127874;.</h1>'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10) + 'Estamos aqui pra lembrar da sua situação, na qual...'
        + CHAR(13) + CHAR(10)
        + CHAR(13) + CHAR(10)
      SELECT
        @EmailBody +=
          CASE
            WHEN @DaysRemaining < 5 AND @DaysRemaining > 0 THEN '<h2>Você terá que pagar o bolo em <b><font color="#ffff00">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias.</h2>'
            WHEN @DaysRemaining = 0 THEN '<h2>Perguntamos. Lembrou de trazer o bolo? Você terá que pagar o bolo <b><font color="#ff6600">hoje!</font></h2>'
            WHEN @DaysRemaining < 0 THEN '<h2>A data pro pagamento do bolo passou &#128544;&#128544; CADE O BOLO? Já fazem <b><font color="#ff0000">' + CAST(@DaysRemaining AS VARCHAR(MAX)) + '</font></b> dias que você está em atraso pilantra!</h2>'
            ELSE ''
          END
      DECLARE @PlanilhaDoBoloPath AS VARCHAR(MAX) = 'C:\TMP\PlanilhaBolo2023.xlsx'
      SET @EmailBody += 
        CHAR(13) + CHAR(10) + '<p><i><font color="#333333">Lembrando que para pedir você pode ligar ou falar no whatsapp com a Casa dos Bolos <a href="+55 16 98809-9251"></a>. '
                            + 'Se quiser pode pedir em outro lugar ou trazer o bolo de casa também.</font></i></p>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Em questão de sabores, é sempre bem vindo o <font color="#7a00cc">Nacional Cenoura com Cobertura de Chocolate</font>. &#128526;</p>'
      + CHAR(13) + CHAR(10)
      /* Cake Layers */
      + CHAR(13) + CHAR(10) + '<div style="width: 120px; height: 50px; border-radius: 5px; margin: 0 auto; background-color: #c266ff; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 140px; height: 50px; border-radius: 10px; margin: 0 auto; background-color: #c24df8; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 160px; height: 50px; border-radius: 15px; margin: 0 auto; background-color: #9f27fa; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10) + '<div style="width: 180px; height: 50px; border-radius: 20px; margin: 0 auto; background-color: #7a00cc; box-shadow: 5px 5px 10px #999;"></div>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Se você quiser ver tabela de preços e como está o andamento da fila, você pode ver a planilha do bolo'
      + CHAR(13) + CHAR(10) + 'aqui na <a href="' + @PlanilhaDoBoloPath + '">planilha do bolo</a> ou no anexo.</p>'
      + CHAR(13) + CHAR(10)
      + CHAR(13) + CHAR(10) + '<p>Seu <b>PILANTRA</b>... &#128580;</p>'

      SET @EmailBody = '<html><body>' + @EmailBody + '</body></html>'

      DECLARE @FileAttachments VARCHAR(MAX) = @PlanilhaDoBoloPath + ';C:\TMP\FiladoBolo\bolo_pulando_feliz.png'
      EXEC sp_send_dbmail
        @profile_name     = 'SQL Profile'
      , @Recipients       = @Email
      , @Subject          = 'Pagamento do Bolo!!'
      , @Body             = @EmailBody
      , @Body_Format      = 'HTML'
      , @file_attachments = @FileAttachments

      PRINT 'Foi enviado um e-mail para ' + @FirstName + ' com o email de "' + @Email + '"!'
    END
  SELECT @CurrentContactId = MIN([ContactId]) FROM @Contact where [ContactId] > @CurrentContactId
END

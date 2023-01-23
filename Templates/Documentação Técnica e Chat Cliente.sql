/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a criação do template para a Documentação
  Técnica.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON

DECLARE @FinalResultText AS VARCHAR(MAX) = ''

-- TOPICO 2
DECLARE @UserChoosenVersion AS TABLE ([FullVersion] VARCHAR(MAX))
INSERT INTO @UserChoosenVersion VALUES ('10.1.6')

DECLARE @UserChoosenApp AS TABLE (ApplicationID INT)
INSERT INTO @UserChoosenApp VALUES (58)

-- TOPICO 3
DECLARE @App TABLE (AplicativoID INT, [Name] VARCHAR(MAX) NOT NULL, [Path] VARCHAR(MAX) NOT NULL)
INSERT INTO @App
VALUES
 ( 1, 'OuroWeb', '\\vm-srvfile01\produtos\erp\medicamento\fontes\versão ' + '[version]' + '\' + '[appproduct]' + '\sub versão\' + '[version]' + '.' + '[subversion]')
,( 6, 'CNAB'   , '\\vm-srvfile01\fontes\application\cnab\teste\' + '[appproduct]' + '\')
,(58, 'OuroNet', '\\vm-srvfile01\fontes\application\ouronet\teste\'       + '[version]' + '\' + '[appproduct]' + '\'            + '[version]' + '.' + '[subversion]')

DECLARE @AppProduct TABLE ([Path] VARCHAR(MAX) NOT NULL, [AplicativoID] INT, [MensagemID] INT)

-- TOPICO 3
DECLARE @Message TABLE (MessageID INT PRIMARY KEY, [Content] VARCHAR(MAX) NOT NULL)
INSERT INTO @Message
VALUES
 (0, 'Rodar os Scripts')
,(1, 'Rodar o pacote de Scripts')
,(3, 'Atualizar o MDE presente na sua máquina')
,(4, 'Atualizar os Setups presentes na sua máquina')
,(5, 'Pegar o arquivo compactado')


-- TOPICO 1
DECLARE @Output TABLE ([Name] VARCHAR(MAX) NOT NULL, MessageID INT)
INSERT INTO @Output
VALUES
 ('Scripts'          , 0)
,('Pacote de Scripts', 1)
,('MDE'              , 2)
,('Setups'           , 3)
,('CNAB'             , 4)




DECLARE @Topic1Number AS INT = 2

DECLARE Topic2 CURSOR LOCAL FOR
  SELECT [FullVersion] FROM @UserChoosenVersion
-- Abrindo o cursor para leitura
OPEN Topic2
  DECLARE @FullVersion AS VARCHAR(MAX)
  FETCH NEXT FROM Topic2 INTO @FullVersion

  DECLARE @Topic2Number AS INT = 1
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @FinalResultText += CAST(@Topic1Number AS VARCHAR) + '.' + CAST(@Topic2Number AS VARCHAR) + ') Versão: ' + @FullVersion + CHAR(13) + CHAR(10)

    DECLARE Topic3 CURSOR LOCAL FOR
      SELECT [ApplicationID] FROM @UserChoosenApp
    -- Abrindo o cursor para leitura
    OPEN Topic3
      DECLARE @ApplicationID AS VARCHAR(MAX)
      FETCH NEXT FROM Topic3 INTO @ApplicationID
      
      DECLARE @Topic3Number AS INT = 1
      WHILE @@FETCH_STATUS = 0
      BEGIN
        SET @FinalResultText += SPACE(2) + CAST(@Topic1Number AS VARCHAR) + '.' + CAST(@Topic2Number AS VARCHAR) + '.' + CAST(@Topic3Number AS VARCHAR) + ') ' + @ApplicationID + CHAR(13) + CHAR(10)

        FETCH NEXT FROM Topic3 INTO @ApplicationID
        SET @Topic3Number = @Topic3Number + 1
      END
    -- Fechando o cursor para leitura
    CLOSE Topic3
    -- Finalizando o cursor
    DEALLOCATE Topic3
    
    SET @Topic2Number = @Topic2Number + 1
    FETCH NEXT FROM Topic2 INTO @FullVersion
  END
-- Fechando o cursor para leitura
CLOSE Topic2
-- Finalizando o cursor
DEALLOCATE Topic2

PRINT @FinalResultText






--DECLARE @OutputValue AS VARCHAR(MAX) = ''
--SET @OutputValue = @OutputValue + ' pelo presente em:'

--SELECT
--  [Versao].[str_Versao]        AS [Versão]
--, [SubVersao].[int_SubVersao]  AS [Sub Versão]
--, [Versao].[fk_int_Aplicativo] AS [Nome do Aplicativo]
--FROM
--  [Versao]    AS [Versao]
--  INNER JOIN
--  [SubVersao] AS [SubVersao] ON [SubVersao].[fk_int_Versao] = [Versao].[pk_int_Versao]
--WHERE
--  @UserChoosenVersion     = RTRIM([Versao].[str_Versao]) + '.' + CAST([SubVersao].[int_SubVersao] AS VARCHAR)
--  AND [fk_int_Aplicativo] = 58
--ORDER BY
--  LEN([Versao].[str_Versao])  DESC
--, [Versao].[str_Versao]       DESC
--, [SubVersao].[int_SubVersao] DESC
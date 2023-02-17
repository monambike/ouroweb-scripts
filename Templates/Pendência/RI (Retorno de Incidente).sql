/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a criação do template para Retorno de RI. Para
  utilizar, basta informar o ID da pendência e rodar o Script.
  O Script retorna apenas erros não corrigidos, mas você pode mudar o filtro para também
  retornar RIs de erros que já foram corrigidos.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
USE [FollowWeb]
DECLARE
  @PendenciaId          AS VARCHAR(MAX) = '<ID da Pendencia, INT, >'
, @AlsoShowFixedErrors  AS VARCHAR(MAX) = '<Também Mostrar Erros Já Corrigidos, BIT, >'

/* Verifica se o usuário informou a pendência para gerar o template */
IF @PendenciaId IN ('', CHAR(60) + 'ID da Pendencia, INT, ' + CHAR(62))
  BEGIN
    PRINT 'É necessário informar uma pendência da qual você queira montar o template antes de continuar.'
    RETURN
  END

/* Verifica se a pendência existe */
IF NOT EXISTS (SELECT IdPendencia FROM Pendencias WHERE IdPendencia = @PendenciaId)
  BEGIN
    PRINT 'A pendência "' + @PendenciaId + '" não existe ou não foi encontrada.'
    RETURN
  END

/* Retorna os erros para a pendência selecionada */
IF(OBJECT_ID('tempdb..#Erros') IS NOT NULL)
  DROP TABLE [dbo].[#Erros]
SELECT
  [Erro].[pk_int_CasoTeste_Erros]
, [Erro].[str_Nome]
INTO
  #Erros
FROM
  [CasoTeste]       AS [CasoTeste]
  INNER JOIN
  [CasoTeste_Erros] AS [Erro] ON [CasoTeste].[pk_int_CasoTeste] = [Erro].[fk_int_CasoTeste]
WHERE
      (CAST([CasoTeste].[int_pendencia] AS VARCHAR) = @PendenciaId)
  AND (@AlsoShowFixedErrors IN ('', CHAR(60) + 'Também Mostrar Erros Já Corrigidos, BIT, ' + CHAR(62), '0')
        OR [Erro].[bit_Corrigido] = 0)

/* Montando o template de acordo com os erros retornados para a pendência selecionada */
DECLARE Erro CURSOR LOCAL FOR
  SELECT * FROM #Erros
OPEN Erro
  DECLARE @ErroID AS VARCHAR(MAX), @ErroAssunto AS VARCHAR(MAX)
  FETCH NEXT FROM Erro INTO @ErroID, @ErroAssunto

  DECLARE @ListaRIs AS VARCHAR(MAX) = ''
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @ListaRIs += @ErroID + ' - ' + @ErroAssunto + CHAR(13) + CHAR(10)
    FETCH NEXT FROM Erro INTO @ErroID, @ErroAssunto
  END
CLOSE Erro
DEALLOCATE Erro

/* Verifica se foram encontrados erros para a pendência */
IF NOT EXISTS(SELECT * FROM #Erros)
  BEGIN
    PRINT 'Não foram encontrados erros relacionados à pendência "' + @PendenciaId + '", por conta disso não foi possível montar o template de RI.'
    RETURN
  END

/* Gera o template final */
DECLARE @Result AS VARCHAR(MAX) = ''
DECLARE @NewLine AS VARCHAR(MAX) = CHAR(13) + CHAR(10) 
SELECT
  @Result =
               [ProjetoTeste].[str_Descricao]
  + @NewLine + 'Pendência ' + CAST([Pendencia].[IdPendencia] AS VARCHAR) + ' - ' + [Pendencia].[Assunto]
  + @NewLine + @ListaRIs
FROM
  [Pendencias] AS [Pendencia]
  LEFT JOIN
  [ProjetoTeste] AS [ProjetoTeste] ON [Pendencia].[fk_int_ProjetoTeste] = [ProjetoTeste].[pk_int_ProjetoTeste]
WHERE
  [Pendencia].[IdPendencia] = @PendenciaId

PRINT @Result

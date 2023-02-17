/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e par�metros a serem
  utilizados nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a cria��o do template para Retorno de RI. Para
  utilizar, basta informar o ID da pend�ncia e rodar o Script.
  O Script retorna apenas erros n�o corrigidos, mas voc� pode mudar o filtro para tamb�m
  retornar RIs de erros que j� foram corrigidos.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
USE [FollowWeb]
DECLARE
  @PendenciaId          AS VARCHAR(MAX) = '<ID da Pendencia, INT, >'
, @AlsoShowFixedErrors  AS VARCHAR(MAX) = '<Tamb�m Mostrar Erros J� Corrigidos, BIT, >'

/* Verifica se o usu�rio informou a pend�ncia para gerar o template */
IF @PendenciaId IN ('', CHAR(60) + 'ID da Pendencia, INT, ' + CHAR(62))
  BEGIN
    PRINT '� necess�rio informar uma pend�ncia da qual voc� queira montar o template antes de continuar.'
    RETURN
  END

/* Verifica se a pend�ncia existe */
IF NOT EXISTS (SELECT IdPendencia FROM Pendencias WHERE IdPendencia = @PendenciaId)
  BEGIN
    PRINT 'A pend�ncia "' + @PendenciaId + '" n�o existe ou n�o foi encontrada.'
    RETURN
  END

/* Retorna os erros para a pend�ncia selecionada */
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
  AND (@AlsoShowFixedErrors IN ('', CHAR(60) + 'Tamb�m Mostrar Erros J� Corrigidos, BIT, ' + CHAR(62), '0')
        OR [Erro].[bit_Corrigido] = 0)

/* Montando o template de acordo com os erros retornados para a pend�ncia selecionada */
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

/* Verifica se foram encontrados erros para a pend�ncia */
IF NOT EXISTS(SELECT * FROM #Erros)
  BEGIN
    PRINT 'N�o foram encontrados erros relacionados � pend�ncia "' + @PendenciaId + '", por conta disso n�o foi poss�vel montar o template de RI.'
    RETURN
  END

/* Gera o template final */
DECLARE @Result AS VARCHAR(MAX) = ''
DECLARE @NewLine AS VARCHAR(MAX) = CHAR(13) + CHAR(10) 
SELECT
  @Result =
               [ProjetoTeste].[str_Descricao]
  + @NewLine + 'Pend�ncia ' + CAST([Pendencia].[IdPendencia] AS VARCHAR) + ' - ' + [Pendencia].[Assunto]
  + @NewLine + @ListaRIs
FROM
  [Pendencias] AS [Pendencia]
  LEFT JOIN
  [ProjetoTeste] AS [ProjetoTeste] ON [Pendencia].[fk_int_ProjetoTeste] = [ProjetoTeste].[pk_int_ProjetoTeste]
WHERE
  [Pendencia].[IdPendencia] = @PendenciaId

PRINT @Result

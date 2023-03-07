/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a criação do template para Checkin.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
USE [FollowWeb]
DECLARE @PendenciaId AS INT = <ID da Pendencia, INT, >

-- =============================================
-- Retornando os requisitos e realizando a montagem
-- de como eles vão ficar no template.
-- =============================================
-- Cursor para percorrer os registros
DECLARE Requisito CURSOR LOCAL FOR
  SELECT [pk_int_Requisito], [str_Nome] FROM [Requisito] WHERE [fk_int_Pendencia] = @PendenciaId ORDER BY [Requisito].[pk_int_Requisito]
OPEN Requisito
  DECLARE @RequisitoID AS VARCHAR(MAX), @RequisitoAssunto AS VARCHAR(MAX)
  FETCH NEXT FROM Requisito INTO @RequisitoID, @RequisitoAssunto

  DECLARE @Requisitos AS VARCHAR(MAX) = ''
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Requisitos += @RequisitoID + ' - ' + REPLACE(LTRIM(RTRIM(@RequisitoAssunto)), CHAR(9), '') + CHAR(13) + CHAR(10)
    FETCH NEXT FROM Requisito INTO @RequisitoID, @RequisitoAssunto
  END
-- Fechando o cursor para leitura
CLOSE Requisito
-- Finalizado o cursor
DEALLOCATE Requisito


-- =============================================
-- Juntando as informações à respeito da pendência
-- com as informações dos requisitos acima.
-- =============================================
DECLARE @Result AS VARCHAR(MAX) = ''
SELECT
  @Result =   CAST([Pendencia].[IdPendencia] AS VARCHAR) + ' - ' + [Pendencia].[Assunto]
            + CHAR(13) + CHAR(10) + @Requisitos
            + [Aplicativo].[str_Nome] + ' ' + LTRIM(RTRIM([Versao].[str_Versao])) + '.' + CAST([SubVersao].[int_SubVersao] AS VARCHAR)
FROM
  [Pendencias] AS [Pendencia]
  INNER JOIN
  [ClienteProdutoAplicativo] AS [ClienteProdutoAplicativo] ON [ClienteProdutoAplicativo].[pk_int_ClienteProdutoAplicativo] = [Pendencia].[fk_int_ProdutoAplicativo]
  INNER JOIN
  [ProdutoAplicativo]        AS [ProdutoAplicativo]        ON [ProdutoAplicativo].[pk_int_ProdutoAplicativo]                = [ClienteProdutoAplicativo].[fk_int_ProdutoAplicativo]
  INNER JOIN
  [Aplicativo]               AS [Aplicativo]               ON [Aplicativo].[pk_int_Aplicativo]                              = [ProdutoAplicativo].[fk_int_Aplicativo]
  INNER JOIN
  [Versao]                   AS [Versao]                   ON [Versao].[pk_int_Versao]                                      = [Pendencia].[fk_int_Versao]
  INNER JOIN
  [SubVersao]                AS [SubVersao]                ON [SubVersao].[fk_int_Versao]                                   = [Versao].[pk_int_Versao]
WHERE
  [Pendencia].[IdPendencia] = @PendenciaId

PRINT @Result

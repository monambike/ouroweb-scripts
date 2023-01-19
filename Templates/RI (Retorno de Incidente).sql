/**************************************************************************************

  Press CTRL + SHIFT + M to define parameters and values to be used on this
  current template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a criação do template para Retorno de RI.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
DECLARE
    @PendenciaId                      AS INT = '<ID da Pendencia, INT, >'
  , @MostrarApenasErrosNaoCorrigidos  AS BIT = '<Mostrar Apenas Erros Corrigidos, BIT, >'

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
      ([CasoTeste].[int_pendencia] = @PendenciaId)
  AND ((@MostrarApenasErrosNaoCorrigidos = '' OR  @MostrarApenasErrosNaoCorrigidos = 0) OR [Erro].[bit_Corrigido] = 0)

-- =============================================
-- Retornando os retornos de incidente (RIs) e
-- realizando a montagem de como elas vão ficar
-- no template.
-- =============================================
-- Cursor para percorrer os registros
DECLARE Erro CURSOR LOCAL FOR
  SELECT * FROM #Erros
OPEN Erro
  DECLARE @ErroID AS VARCHAR(MAX), @ErroAssunto AS VARCHAR(MAX)
  FETCH NEXT FROM Erro INTO @ErroID, @ErroAssunto

  DECLARE @Erros AS VARCHAR(MAX) = ''
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Erros += @ErroID + ' - ' + @ErroAssunto + CHAR(13) + CHAR(10)
    FETCH NEXT FROM Erro INTO @ErroID, @ErroAssunto
  END
-- Fechando Cursor para leitura
CLOSE Erro
-- Finalizado o cursor
DEALLOCATE Erro

IF NOT EXISTS(SELECT * FROM #Erros)
  PRINT 'Essa pendência não possui nenhum erro.'
ELSE IF EXISTS(SELECT * FROM #Erros) AND @MostrarApenasErrosNaoCorrigidos = 1
  PRINT 'Essa pendência possui alguns erros mas nenhum a ser corrigido. Para visualizar os erros não corrigidos defina o parâmetro ''@MostrarApenasErrosNaoCorrigidos'' como ''0''.'
ELSE
BEGIN
  -- =============================================
  -- Juntando as informações à respeito da pendência
  -- com as informações dos erros acima.
  -- =============================================
  DECLARE @Result AS VARCHAR(MAX) = ''
  SELECT
    @Result = [ProjetoTeste].[str_Descricao]
              + CHAR(13) + CHAR(10) + 'Pendência ' + CAST([Pendencia].[IdPendencia] AS VARCHAR) + ' - ' + [Pendencia].[Assunto]
              + CHAR(13) + CHAR(10) + @Erros
  FROM
    [Pendencias] AS [Pendencia]
    INNER JOIN
    [ProjetoTeste] AS [ProjetoTeste] ON [Pendencia].[fk_int_ProjetoTeste] = [ProjetoTeste].[pk_int_ProjetoTeste]
  WHERE
    [Pendencia].[IdPendencia] = @PendenciaId

  PRINT @Result
END
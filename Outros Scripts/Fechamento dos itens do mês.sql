/**************************************************************************************

  Pressione "[F5]" para utilizar do Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo parar a lentidão na abertura do OuroWeb quando causada
  pela procedure de fechmaento dos itens no mês.


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  Rodar o Script abaixo caso o seu OuroWeb estiver lento ao iniciar por conta do mês
  atual não estar fechado na tabela:

  DECLARE @CurrentMonth AS INT = CAST(MONTH(GETDATE()) AS INT), @CurrentYear AS INT = CAST(YEAR(GETDATE()) AS INT)
  DECLARE @MessagePrefix AS VARCHAR(10)
  IF NOT EXISTS (SELECT pk_int_FechamentoMes FROM FechamentoMes WHERE int_Mes = @CurrentMonth AND int_Ano = @CurrentYear)
    BEGIN
      EXEC sp_mng_CriarFechamentoMes @CurrentMonth, @CurrentYear
      SET @MessagePrefix = 'Foi inserido'
    END
  ELSE SET @MessagePrefix = 'Já existe'

  PRINT @MessagePrefix + ' o fechamento para o mês "' + CAST(@CurrentMonth AS VARCHAR(2)) + '" do ano "' + FORMAT(@CurrentYear, 'yy') + '".'

  EXEC sp_lst_FechamentoMes @CurrentMonth, @CurrentYear
  GO

  UPDATE [FechamentoMes]
  SET
    [bit_MesFechado]         = 1
  , [dte_DataHoraFechamento] = GETDATE()
  , [fk_int_IdUsuario]       = 66
  WHERE int_Mes = CAST(MONTH(GETDATE()) AS INT) AND int_Ano = CAST(YEAR(GETDATE()) AS INT)

**************************************************************************************/

SELECT
  [a].[pk_int_FechamentoMes]
, [a].[bit_MesFechado]
, *
FROM
  [FechamentoMes] a WITH(NOLOCK)
ORDER BY
  [dte_DataHoraFechamento] DESC


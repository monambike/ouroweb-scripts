/**************************************************************************************



  BEGIN TRAN UPDATE [FechamentoMes] SET [bit_MesFechado] = 1
  COMMIT

**************************************************************************************/

SELECT
    [a].[pk_int_FechamentoMes]
  , [a].[bit_MesFechado],
  *
FROM
  FechamentoMes a WITH(NOLOCK)

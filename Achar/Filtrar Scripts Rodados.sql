IF EXISTS(

CREATE PROCEDURE usp_lst_FiltrarPorScriptsRodados
    @ScriptInicioDataInicial AS DATETIME = NULL,
    @ScriptInicioDataFinal AS DATETIME = NULL,
    /****************************************
    0 - Sort using ASC
    1 - Sort using DESC
    ****************************************/
    @AscDesc AS BIT = NULL
AS
BEGIN TRY
  SELECT
    'Nome do Script' = str_NomeScript,
    'Caminho do Script' = str_NomeCompleto,
    'Horario - Script Foi Rodado' = str_DataInicio,
    'Horario - Terminou de Rodar' = str_DataTermino,
    'Sucesso' = bit_Sucesso,
    'Duração' = FORMAT(str_DataTermino - str_DataInicio, 'HH:mm:ss:fff')
  FROM
    LogScript WITH(NOLOCK)
  WHERE
    (@ScriptInicioDataInicial IS NULL OR str_DataInicio >= @ScriptInicioDataInicial) AND
    (@ScriptInicioDataFinal IS NULL OR str_DataInicio <= @ScriptInicioDataFinal)
  ORDER BY
    (CASE WHEN @AscDesc = 0 THEN str_DataInicio END) ASC,
    (CASE WHEN @AscDesc = 1 THEN str_DataInicio END) DESC 
END TRY
BEGIN CATCH
END CATCH
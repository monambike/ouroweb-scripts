/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script vai mostrar outros Scripts que foram rodados nessa base por meio do pacote
  de Scripts.
  
  ===================================================================================
   Filtros Selecionados
  ===================================================================================

  Mostrando objetos que apenas..
  Com data posterior a:                              "<Filtrar por: Nome do Objeto, VARCHAR, >"
  Com data anterior a:                               "<Filtrar por: Data Inicial, VARCHAR, >"
  Scripts bem sucedidos:                             "<Mostrar Apenas: Apenas Scripts Sucedidos, BIT, >"

  Ordenar por..
  Data de Início (0 - Ascendente / 1 - Descendente): "<Ordenar por: Ascendente ou Descendente, BIT, >"

**************************************************************************************/

DECLARE
  @ScriptInicioDataInicial AS DATETIME = '<Filtrar por: Data Inicial, VARCHAR, >'
, @ScriptInicioDataFinal   AS DATETIME = '<Filtrar por: Data Inicial, VARCHAR, >'
, @ScriptSucesso           AS BIT      = '<Mostrar Apenas: Apenas Scripts Sucedidos, BIT, >'
, @AscDesc                 AS BIT      = '<Ordenar por: Ascendente ou Descendente, BIT, >'


SELECT
  [str_NomeScript]                                             AS [Nome do Script]
, [str_NomeCompleto]                                           AS [Caminho do Script]
, [str_DataInicio]                                             AS [Horario - Script Foi Rodado]
, [str_DataTermino]                                            AS [Horario - Terminou de Rodar]
, [bit_Sucesso]                                                AS [Sucesso]
, FORMAT([str_DataTermino] - [str_DataInicio], 'HH:mm:ss:fff') AS [Duração]
FROM
  [LogScript] WITH(NOLOCK)
WHERE
  (@ScriptInicioDataInicial = '' OR [str_DataInicio] >= @ScriptInicioDataInicial)
  AND (@ScriptInicioDataFinal = '' OR [str_DataInicio] <= @ScriptInicioDataFinal)
ORDER BY
  (CASE WHEN @AscDesc = 0 THEN [str_DataInicio] END) ASC
, (CASE WHEN @AscDesc = 1 THEN [str_DataInicio] END) DESC 

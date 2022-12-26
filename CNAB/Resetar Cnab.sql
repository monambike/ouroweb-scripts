SELECT
  FoiPago,
  ValorPagamento,
  IdMovimento,
  DataPagamento,
  DataEntradaCaixa,
  bit_TituloBaixadoPeloCNAB,
  *
FROM
  Mov_Financeiro
WHERE
  1=1
  AND IdBanco LIKE '%Uni%'
  AND IdMovimento IN (39111)
  AND FoiPago = 1

-- Tabela com as situações (ocorrências do título) para cada banco
SELECT * FROM Tab_RetornoMensagemBanco

/**************************************************************************************
  
-- Update para permitir ler novamente o arquivo retorno
UPDATE
  Mov_Financeiro
SET
  FoiPago = 0
  , DataPagamento = null
  , DataEntradaCaixa = null
  , bit_TituloBaixadoPeloCNAB = 0
WHERE
  IdMovimento In (39111,39112) --<< Colocar CR aqui
  --And FoiPago = 0 --<< ) para ler novamente o arquivo retorno

**************************************************************************************/
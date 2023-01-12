DECLARE
    @IdBanco     AS VARCHAR(MAX) = '<Filtrar por: Nome do Banco (Coluna IdBanco), VARCHAR(MAX), >'
  , @IdMovimento AS VARCHAR(MAX) = '<Filtrar por: IdMovimento (CR), INT, >'
  , @FoiPago     AS VARCHAR(MAX) = '<Filtrar por: Foi Pago, BIT, >'

SELECT
    [FoiPago]                   AS [Foi Pago]
  , [bit_TituloBaixadoPeloCNAB] AS [Título Baixado Pelo CNAB]
  , [IdMovimento]               AS [IdMovimento (CR)]
  , [IdCadastro]                AS [IdCadastro]
  , [IdBanco]                   AS [IdBanco]
  , [NúmeroDocumento]           AS [Número do Documento]
  , [ValorPagamento]            AS [Valor do Pagamento]
  , [ValorDocumento]            AS [Valor do Documento]
  , [DataPagamento]             AS [Data do Pagamento]
  , [DataÚltimaAlteração]       AS [Data da Última Alteração]
  , [DataVencimento]            AS [Data do Vencimento]
  , [DataEntradaCaixa]          AS [Data da Entrada no Caixa]
  , [DataCadastro]              AS [Data do Cadastro]
  , [DataEmissão]               AS [Data da Emissão]
FROM
  [Mov_Financeiro]
WHERE
  (@IdBanco         = '' OR IdBanco     LIKE '%' + @IdBanco + '%')
  AND (@IdMovimento = '' OR IdMovimento =    @IdMovimento)
  --AND IdMovimento IN (0)
  AND (@FoiPago     = '' OR FoiPago     =    @FoiPago)

/**************************************************************************************
  
  -- Tabela com as situações (ocorrências do título) para cada banco
  SELECT * FROM [Tab_RetornoMensagemBanco]

  -- Update para permitir ler novamente o arquivo retorno
  UPDATE
    [Mov_Financeiro]
  SET
      [FoiPago]                   = 0
    , [DataPagamento]             = NULL
    , [DataEntradaCaixa]          = NULL
    , [bit_TituloBaixadoPeloCNAB] = 0
  WHERE
    [FoiPago] = 1                  -- Olhando somente movimentos que não foram pagos para ler
                                   -- novamente o arquivo retorno
    AND [IdMovimento] IN (39111,39112) -- Colocar o "CR" aqui

**************************************************************************************/
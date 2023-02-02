/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a busca por títulos (baixados ou não) pelo
  CNAB presentes na telinha de "Contas à Receber" do OuroWeb.
  "Movimento > Financeiro > Contas a Receber"

  No final do Script também há um "UPDATE" para que o título possa ser lido novamente
  pelo CNAB.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE
  @IdBanco     AS VARCHAR(MAX) = '<Filtrar por: Nome do Banco (Coluna IdBanco), VARCHAR(MAX), >'
, @IdMovimento AS VARCHAR(MAX) = '<Filtrar por: IdMovimento (CR),               VARCHAR(MAX), >'
, @FoiPago     AS VARCHAR(MAX) = '<Filtrar por: Foi Pago,                       BIT,          >'

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
      (@IdBanco IN ('', CHAR(60) + 'Filtrar por: Nome do Banco (Coluna IdBanco), VARCHAR(MAX), ' + CHAR(62))
        OR IdBanco                   LIKE '%' + @IdBanco + '%')
  AND (@IdMovimento  IN ('', CHAR(60) + 'Filtrar por: IdMovimento (CR), VARCHAR(MAX), ' + CHAR(62))
        OR CAST(IdMovimento AS VARCHAR) =    @IdMovimento)
  AND (@FoiPago IN ('', CHAR(60) + 'Filtrar por: Foi Pago, BIT, ' + CHAR(62))
        OR CAST(FoiPago     AS VARCHAR) =    @FoiPago)
  /* (IdMovimento IN (0)) */

/**************************************************************************************

  Tabela com as situações (ocorrências do título) para cada banco:
  SELECT * FROM [Tab_RetornoMensagemBanco]

  Update para permitir ler novamente o arquivo retorno:
  UPDATE
    [Mov_Financeiro]
  SET
    [FoiPago]                   = 0
  , [DataPagamento]             = NULL
  , [DataEntradaCaixa]          = NULL
  , [bit_TituloBaixadoPeloCNAB] = 0
  WHERE
    [IdMovimento] IN (39111,39112) /* Colocar o "CR" aqui */
    AND [FoiPago] = 1              /* Olhando somente movimentos que não foram pagos para ler
                                      novamente o arquivo retorno */

**************************************************************************************/
/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e par�metros a serem
  utilizados nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a busca por t�tulos (baixados ou n�o) pelo
  CNAB presentes na telinha de "Contas � Receber" do OuroWeb.
  "Movimento > Financeiro > Contas a Receber"

  No final do Script tamb�m h� um "UPDATE" para que o t�tulo possa ser lido novamente
  pelo CNAB.

**************************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE
  @IdBanco     AS VARCHAR(MAX) = '<Filtrar por: Nome do Banco (Coluna IdBanco), VARCHAR(MAX), >'
, @IdMovimento AS VARCHAR(MAX) = '<Filtrar por: IdMovimento (CR),               VARCHAR(MAX), >'
, @FoiPago     AS VARCHAR(MAX) = '<Filtrar por: Foi Pago,                       BIT,          >'

SELECT
  [FoiPago]                   AS [Foi Pago]
, [bit_TituloBaixadoPeloCNAB] AS [T�tulo Baixado Pelo CNAB]
, [IdMovimento]               AS [IdMovimento (CR)]
, [IdCadastro]                AS [IdCadastro]
, [IdBanco]                   AS [IdBanco]
, [N�meroDocumento]           AS [N�mero do Documento]
, [ValorPagamento]            AS [Valor do Pagamento]
, [ValorDocumento]            AS [Valor do Documento]
, [DataPagamento]             AS [Data do Pagamento]
, [Data�ltimaAltera��o]       AS [Data da �ltima Altera��o]
, [DataVencimento]            AS [Data do Vencimento]
, [DataEntradaCaixa]          AS [Data da Entrada no Caixa]
, [DataCadastro]              AS [Data do Cadastro]
, [DataEmiss�o]               AS [Data da Emiss�o]
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

  Tabela com as situa��es (ocorr�ncias do t�tulo) para cada banco:
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
    AND [FoiPago] = 1              /* Olhando somente movimentos que n�o foram pagos para ler
                                      novamente o arquivo retorno */

**************************************************************************************/
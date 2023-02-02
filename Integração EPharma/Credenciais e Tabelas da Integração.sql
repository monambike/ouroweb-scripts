/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio no desenvolvimento, teste e compreensão da
  "Integração EPharma".


  ===================================================================================
   Credenciais
  ===================================================================================

  MGMED
  Site de Teste: http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx
  Usuário: 11719795000370
  Senha: 123456
  Servico: WsDelivery
  Empresa a Consultar: 11719795000370

  Site de Produção http://webservice.epharma.com.br/WsConcentrador.asmx?WSDL
  Usuário: 11719795000370
  Senha: JgtHbfeL
  Empresa a Consultar: 11719795000370


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================
  
  -- Tabelas de configuração da Integração EPharma
  SELECT * FROM Tab_EpharmaMoveConfig
  SELECT * FROM Tab_ConfiguracaoEPharma

  Configurar a integração da EPharma para o ambiente de homologação:
  UPDATE Tab_EpharmaMoveConfig
  SET
    [str_UrlServico] = 'http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx'
  , [str_Usuario]    = 11719795000370
  , [str_Senha]      = 123456


  ===================================================================================
   Outras Tabelas que podem ser Úteis
  ===================================================================================

  -- Dados do Convênio
  SELECT * FROM Tab_EPharma_Convenios
  SELECT * FROM Tab_EPharma_Convenios_Estado

  -- Dados da Reposta
  SELECT * FROM Tmp_EPharmaResposta
  SELECT * FROM Tmp_EPharmaRespostaAutorizacaoItens
  Apagar os movimentos da base para que possam ser solicitados novamente:

**************************************************************************************/

SELECT
  [pedido].[pk_int_Mov_EpharmaMovePedido] AS [PK do Pedido]
, [pedido].[dte_DataResposta]             AS [Data e Hora Resposta]
, [pedido].[dte_DataHoraPedido]           AS [Data e Hora Pedido]
, [pedido].[str_Cnpj]                     AS [CNPJ]
, [pedido].[int_NumeroDocumento]          AS [Número do Documento]
, [pedido].[int_NumeroPedido]             AS [Número do Pedido]
, [item].[pk_int_Mov_EpharmaMovePedidoItens] AS [PK do Item]
, [item].[str_NomeProduto]                   AS [Nome do Produto]
, [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]                   AS [PK Beneficiario]
, [beneficiario_endereco].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiarioEndereco]  AS [PK Beneficiario Endereço]
, [beneficiario_telefone].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiarioTelefones] AS [PK Beneficiario Telefone]
, [cliente].[pk_int_Mov_EpharmaMovePedidoDadosCliente]                             AS [PK Cliente]
, [clinico].[pk_int_Mov_EpharmaMovePedidoDadosClinicos]                            AS [PK Clinico]
FROM
  [Mov_EpharmaMovePedido]                           AS [pedido]
  FULL JOIN
  [Mov_EpharmaMovePedidoItens]                      AS [item]                  ON [pedido].[pk_int_Mov_EpharmaMovePedido] = [item].[fk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  [Mov_EpharmaMovePedidoDadosBeneficiario]          AS [beneficiario]          ON [beneficiario].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  [Mov_EpharmaMovePedidoDadosBeneficiarioEndereco]  AS [beneficiario_endereco] ON [beneficiario_endereco].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario]  = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  FULL JOIN
  [Mov_EpharmaMovePedidoDadosBeneficiarioTelefones] AS [beneficiario_telefone] ON [beneficiario_telefone].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario] = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  FULL JOIN
  [Mov_EpharmaMovePedidoDadosCliente]               AS [cliente]               ON [cliente].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  [Mov_EpharmaMovePedidoDadosClinicos]              AS [clinico]               ON [clinico].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
ORDER BY [dte_DataResposta] DESC

/**************************************************************************************

  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  O Script abaixo serve para poder apagar movimentos para que possam ser solicitados
  novamente na tela "Pedidos Delivery ePharma Move".

  Favor selecionar todas as consultas abaixo para apagar os pedidos que estão com o
  campo "dte_DataResposta" como "NULL" ou com a data posterior à data informada na
  variável "@AfterMonthsAgo".
  Informar "0" fará com que apague registros referentes ao mês atual, informar "1"
  fará com que apague do mês passado e do mês atual, e assim por diante.


  DECLARE @AfterMonthsAgo AS INT = 0
  DELETE [pedido] FROM [Mov_EpharmaMovePedido] AS [pedido]
  WHERE 
    [pedido].[dte_DataResposta] IS NULL
    OR      (MONTH([pedido].[dte_DataResposta]) = MONTH(DATEADD(MONTH, - @AfterMonthsAgo, GETDATE()))
        AND  YEAR([pedido].[dte_DataResposta])  =  YEAR(DATEADD(MONTH, - @AfterMonthsAgo, GETDATE())))

  DELETE
    [item]
  FROM
    [Mov_EpharmaMovePedido]                           AS [pedido]
    FULL JOIN
    [Mov_EpharmaMovePedidoItens]                      AS [item]                  ON [pedido].[pk_int_Mov_EpharmaMovePedido] = [item].[fk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL


  DELETE
    [beneficiario]
  FROM
    [Mov_EpharmaMovePedido]                           AS [pedido]
    FULL JOIN
    [Mov_EpharmaMovePedidoDadosBeneficiario]          AS [beneficiario]          ON [beneficiario].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

  DELETE
    [beneficiario_endereco]
  FROM
    [Mov_EpharmaMovePedidoDadosBeneficiario]          AS [beneficiario]
    FULL JOIN
    [Mov_EpharmaMovePedidoDadosBeneficiarioEndereco]  AS [beneficiario_endereco] ON [beneficiario_endereco].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario]  = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  WHERE [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario] IS NULL

  DELETE [beneficiario_telefone]
  FROM
    [Mov_EpharmaMovePedidoDadosBeneficiario]          AS [beneficiario]
    FULL JOIN
    [Mov_EpharmaMovePedidoDadosBeneficiarioTelefones] AS [beneficiario_telefone] ON [beneficiario_telefone].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario] = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  WHERE [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario] IS NULL


  DELETE
    [cliente]
  FROM
    [Mov_EpharmaMovePedido]                           AS [pedido]
    FULL JOIN
    [Mov_EpharmaMovePedidoDadosCliente]               AS [cliente]               ON [cliente].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

  DELETE
    [clinico]
  FROM
    [Mov_EpharmaMovePedido]                           AS [pedido]
    FULL JOIN
    [Mov_EpharmaMovePedidoDadosClinicos]              AS [clinico]               ON [clinico].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

**************************************************************************************/
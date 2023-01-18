/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script serve como aux�lio no desenvolvimento, teste e compreens�o da
  "Integra��o EPharma".


  ===================================================================================
   Credenciais
  ===================================================================================

  MGMED
  Site de Teste: http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx
  Usu�rio: 11719795000370
  Senha: 123456
  Servico: WsDelivery
  Empresa a Consultar: 11719795000370

  Site de Produ��o http://webservice.epharma.com.br/WsConcentrador.asmx?WSDL
  Usu�rio: 11719795000370
  Senha: JgtHbfeL
  Empresa a Consultar: 11719795000370


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================
  
  -- Tabelas de configura��o da Integra��o EPharma
  SELECT * FROM Tab_EpharmaMoveConfig
  SELECT * FROM Tab_ConfiguracaoEPharma

  Configurar a integra��o da EPharma para o ambiente de homologa��o:
  UPDATE Tab_EpharmaMoveConfig
  SET
    [str_UrlServico] = 'http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx'
  , [str_Usuario]    = 11719795000370
  , [str_Senha]      = 123456


  ===================================================================================
   Outras Tabelas que podem ser �teis
  ===================================================================================

  -- Dados do Conv�nio
  SELECT * FROM Tab_EPharma_Convenios
  SELECT * FROM Tab_EPharma_Convenios_Estado

  -- Dados da Reposta
  SELECT * FROM Tmp_EPharmaResposta
  SELECT * FROM Tmp_EPharmaRespostaAutorizacaoItens
  Apagar os movimentos da base para que possam ser solicitados novamente:

**************************************************************************************/


-- Dados do Pedido
SELECT
  [pedido].[pk_int_Mov_EpharmaMovePedido] AS [PK do Pedido]
, [pedido].[dte_DataResposta]             AS [Data e Hora Resposta]
, [pedido].[dte_DataHoraPedido]           AS [Data e Hora Pedido]
, [pedido].[str_Cnpj]                     AS [CNPJ]
, [pedido].[int_NumeroDocumento]          AS [N�mero do Documento]
, [pedido].[int_NumeroPedido]             AS [N�mero do Pedido]
, [item].[pk_int_Mov_EpharmaMovePedidoItens] AS [PK do Item]
, [item].[str_NomeProduto]                   AS [Nome do Produto]
, [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]                   AS [PK Beneficiario]
, [beneficiario_endereco].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiarioEndereco]  AS [PK Beneficiario Endere�o]
, [beneficiario_telefone].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiarioTelefones] AS [PK Beneficiario Telefone]
, [cliente].[pk_int_Mov_EpharmaMovePedidoDadosCliente]                             AS [PK Cliente]
, [clinico].[pk_int_Mov_EpharmaMovePedidoDadosClinicos]                            AS [PK Clinico]
FROM
  Mov_EpharmaMovePedido                           AS [pedido]
  FULL JOIN
  Mov_EpharmaMovePedidoItens                      AS [item]                  ON [pedido].[pk_int_Mov_EpharmaMovePedido] = [item].[fk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  Mov_EpharmaMovePedidoDadosBeneficiario          AS [beneficiario]          ON [beneficiario].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  Mov_EpharmaMovePedidoDadosBeneficiarioEndereco  AS [beneficiario_endereco] ON [beneficiario_endereco].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario]  = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  FULL JOIN
  Mov_EpharmaMovePedidoDadosBeneficiarioTelefones AS [beneficiario_telefone] ON [beneficiario_telefone].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario] = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  FULL JOIN
  Mov_EpharmaMovePedidoDadosCliente               AS [cliente]               ON [cliente].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  FULL JOIN
  Mov_EpharmaMovePedidoDadosClinicos              AS [clinico]               ON [clinico].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
ORDER BY [dte_DataResposta] DESC


/**************************************************************************************

  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  APAGAR TODOS OS DADOS REFERENTES AOS PEDIDOS N�O RESPONDIDOS OU RESPONDIDOS NOS �LTIMOS 3 MESES
  Favor selecionar toda a consulta abaixo para apagar todos os pedidos que est�o com o
  campo "dte_DataResposta" como "NULL" ou com data posterior aos �ltimos 3 meses.
  Isso � �til para poder solicitar os pedidos novamente na tela "Pedidos Delivery ePharma Move".


  -- Apaga registros do m�s do ano atual, na tabela de pedido
  DELETE
    [pedido]
  FROM
    Mov_EpharmaMovePedido AS [pedido]
  WHERE
         (MONTH([pedido].[dte_DataResposta]) >= MONTH(DATEADD(MONTH, - 3, GETDATE()))
      AND  YEAR([pedido].[dte_DataResposta]) >=  YEAR(DATEADD(MONTH, - 3, GETDATE())))
    OR [pedido].[dte_DataResposta] IS NULL

  DELETE
    [item]
  FROM
    Mov_EpharmaMovePedido                           AS [pedido]
    FULL JOIN
    Mov_EpharmaMovePedidoItens                      AS [item]                  ON [pedido].[pk_int_Mov_EpharmaMovePedido] = [item].[fk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

  DELETE
    [beneficiario]
  FROM
    Mov_EpharmaMovePedido                           AS [pedido]
    FULL JOIN
    Mov_EpharmaMovePedidoDadosBeneficiario          AS [beneficiario]          ON [beneficiario].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

  DELETE
    [beneficiario_endereco]
  FROM
    Mov_EpharmaMovePedidoDadosBeneficiario          AS [beneficiario]
    FULL JOIN
    Mov_EpharmaMovePedidoDadosBeneficiarioEndereco  AS [beneficiario_endereco] ON [beneficiario_endereco].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario]  = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  WHERE [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario] IS NULL

  DELETE [beneficiario_telefone]
  FROM
    Mov_EpharmaMovePedidoDadosBeneficiario          AS [beneficiario]
    FULL JOIN
    Mov_EpharmaMovePedidoDadosBeneficiarioTelefones AS [beneficiario_telefone] ON [beneficiario_telefone].[fk_int_Mov_EpharmaMovePedidoDadosBeneficiario] = [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario]
  WHERE [beneficiario].[pk_int_Mov_EpharmaMovePedidoDadosBeneficiario] IS NULL

  DELETE
    [cliente]
  FROM
    Mov_EpharmaMovePedido                           AS [pedido]
    FULL JOIN
    Mov_EpharmaMovePedidoDadosCliente               AS [cliente]               ON [cliente].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

  DELETE
    [clinico]
  FROM
    Mov_EpharmaMovePedido                           AS [pedido]
    FULL JOIN
    Mov_EpharmaMovePedidoDadosClinicos              AS [clinico]               ON [clinico].[fk_int_Mov_EpharmaMovePedido] = [pedido].[pk_int_Mov_EpharmaMovePedido]
  WHERE [pedido].[pk_int_Mov_EpharmaMovePedido] IS NULL

**************************************************************************************/
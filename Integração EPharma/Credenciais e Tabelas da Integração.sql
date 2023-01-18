/**************************************************************************************

  Press "[F5]" to use the Script below.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio no desenvolvimento, teste e compreensão da
  integração EPharma.


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
   Scripts Auxiliares
  ===================================================================================

  Configurar a integração da EPharma para o ambiente de homologação:
  UPDATE Tab_EpharmaMoveConfig
  SET
    [str_UrlServico] = 'http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx'
  , [str_Usuario]    = 11719795000370
  , [str_Senha]      = 123456

**************************************************************************************/

-- Configurações da Integração EPharma
SELECT * FROM Tab_EpharmaMoveConfig
SELECT * FROM Tab_ConfiguracaoEPharma

-- Dados do Pedido
SELECT * FROM Mov_EpharmaMovePedido
SELECT * FROM Mov_EpharmaMovePedidoItens

-- Dados do Beneficiário
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiario
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiarioEndereco
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiarioTelefones
-- Dados do Cliente e Clínico
SELECT * FROM Mov_EpharmaMovePedidoDadosCliente
SELECT * FROM Mov_EpharmaMovePedidoDadosClinicos
-- Dados do Convênio
SELECT * FROM Tab_EPharma_Convenios
SELECT * FROM Tab_EPharma_Convenios_Estado

-- Dados da Reposta
SELECT * FROM Tmp_EPharmaResposta
SELECT * FROM Tmp_EPharmaRespostaAutorizacaoItens

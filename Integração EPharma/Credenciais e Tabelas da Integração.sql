/**************************************************************************************

  Press "[F5]" to use the Script below.

  ===================================================================================
   Script Short Description
  ===================================================================================

  Esse Script serve como aux�lio no desenvolvimento, teste e compreens�o da
  integra��o EPharma.


  ===================================================================================
   Credenciais
  ===================================================================================

  MGMED
  Site de Teste: http://wshomolo.pbms.com.br:8010/WsConcentrador.asmx
  Usu�rio: 11719795000370
  Senha: 123456
  Servico: WsDelivery
  Empresa a Consultar: 11719795000370

**************************************************************************************/

-- Configura��es da Integra��o EPharma
SELECT * FROM Tab_EpharmaMoveConfig
SELECT * FROM Tab_ConfiguracaoEPharma

-- Dados do Pedido
SELECT * FROM Mov_EpharmaMovePedido
SELECT * FROM Mov_EpharmaMovePedidoItens

-- Dados do Benefici�rio
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiario
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiarioEndereco
SELECT * FROM Mov_EpharmaMovePedidoDadosBeneficiarioTelefones
-- Dados do Cliente e Cl�nico
SELECT * FROM Mov_EpharmaMovePedidoDadosCliente
SELECT * FROM Mov_EpharmaMovePedidoDadosClinicos
-- Dados do Conv�nio
SELECT * FROM Tab_EPharma_Convenios
SELECT * FROM Tab_EPharma_Convenios_Estado

-- Dados da Reposta
SELECT * FROM Tmp_EPharmaResposta
SELECT * FROM Tmp_EPharmaRespostaAutorizacaoItens

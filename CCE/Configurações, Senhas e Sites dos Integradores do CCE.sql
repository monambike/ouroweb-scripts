/**************************************************************************************

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script serve como auxílio no desenvolvimento, teste e compreensão do CCE
  (Central de Cotações Eletrônicas).

  ===================================================================================
   Malha
  ===================================================================================

  Link da Malha: http://172.31.1.11:8091/ws/WSMALHA.apw
  cotacoesouro@grupoelfa.com.br
  smtp.office365.com
  Elfa@2020


  ===================================================================================
   Envio de Email ao Responder Cotação do CCE
  ===================================================================================

  Integrações >> Integração CCe >> Cadastro de Configuração >> Aba Email
  E-mail: teste@ouroweb.com.br
  Host: smtp.office365.com
  Senha: 2wsx@dr5 
  Porta: 587
  Config.SSL: Sim

  [ATENÇÃO] Se ativar, lembre-se de mudar o email dos usuários para o seu
  Enviar E-mail de cotações confirmadas para o usuário: Sim
  Enviar E-mail de cotações para os representantes: Sim


  ===================================================================================
   Credenciais dos Integradores
  ===================================================================================

  BIONEXO
  Site do Integrador: https://bionexo.com/
  ------------------------------------------------------------
  URL: https://sandbox-web.bionexo.com.br/index3.jsp
  Usuário: comprador_teste
  Senha: 2wsx@dr5

  URL: https://ws-bionexo-sandbox.bionexo.com/ws2/BionexoBean?wsdl
  Usuario: Fornecedor_teste
  Senha: Bionexo123


  APOIO
  Link do Site: http://homologacao.apoiocotacoes.com.br/
  ------------------------------------------------------------
  URL: http://homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl 
  Usuário: ELFASC 
  Senha: qetuo

  URL: http://ws.homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl
  Usuario: elfaws
  Senha: 3lf4ws2501


  SÍNTESE
  Link do Site: https://www.plataformasintese.com/saude/
  ------------------------------------------------------------
  URL: https://sintese-sandbox.bionexo.com/integrationservice.asmx?wsdl
  Usuario: ouroweb100
  Senha: Sintese@123


  ===================================================================================
   Atualizar Credenciais dos Integradores
  ===================================================================================

  /* Bionexo */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'Fornecedor_teste' , [str_Senha] = 'Bionexo123' , [str_Url] = 'http://ws-bionexo-sandbox.bionexo.com/ws2/BionexoBean?wsdl'                      WHERE [int_IdLayout] = 1
  /* Apoio   */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'elfaws'           , [str_Senha] = '3lf4ws2501' , [str_Url] = 'http://ws.homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl' WHERE [int_IdLayout] = 2
  /* Síntese */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'ouroweb100'       , [str_Senha] = 'Sintese@123', [str_Url] = 'http://sintese-sandbox.bionexo.com/integrationservice.asmx?wsdl'                 WHERE [int_IdLayout] = 3
  SELECT * FROM Tab_CceLayoutConfig

**************************************************************************************/

/**************************************************************************************

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script serve como aux�lio no desenvolvimento, teste e compreens�o do CCE
  (Central de Cota��es Eletr�nicas).

  ===================================================================================
   Malha
  ===================================================================================

  Link da Malha: http://172.31.1.11:8091/ws/WSMALHA.apw
  cotacoesouro@grupoelfa.com.br
  smtp.office365.com
  Elfa@2020


  ===================================================================================
   Envio de Email ao Responder Cota��o do CCE
  ===================================================================================

  Integra��es >> Integra��o CCe >> Cadastro de Configura��o >> Aba Email
  E-mail:�teste@ouroweb.com.br
  Host: smtp.office365.com
  Senha: 2wsx@dr5�
  Porta: 587
  Config.SSL: N�o

  UPDATE Tab_CceConfig
  SET
    str_Email               = 'teste@ouroweb.com.br'
  , str_Host                = 'smtp.office365.com'
  , str_Senha               = '2wsx@dr5'
  , int_Porta               = 587
  , bit_ConfigSsl           = 0
  , bit_EnviarConfirmadas   = 1
  , bit_EnviarRepresentante = 1

  [ATEN��O] Se ativar, lembre-se de mudar o email dos usu�rios para o seu
  Enviar E-mail de cota��es confirmadas para o usu�rio: Sim
  Enviar E-mail de cota��es para os representantes: Sim


  ===================================================================================
   Credenciais dos Integradores
  ===================================================================================

  BIONEXO
  Site do Integrador: https://bionexo.com/
  ------------------------------------------------------------
  URL: https://sandbox-web.bionexo.com.br/index3.jsp
  Usu�rio: comprador_teste
  Senha: 2wsx@dr5

  URL: https://ws-bionexo-sandbox.bionexo.com/ws2/BionexoBean?wsdl
  Usuario: Fornecedor_teste
  Senha: Bionexo123
  /* Atualizar "Tab_CceLayoutConfig" com as credencias acima */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'Fornecedor_teste', [str_Senha] = '2wsx@dr5', str_Url = 'http://ws-bionexo-sandbox.bionexo.com/ws2/BionexoBean?wsdl' WHERE [int_IdLayout] = 1


  APOIO
  Link do Site: http://homologacao.apoiocotacoes.com.br/
  ------------------------------------------------------------
  URL: http://homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl 
  Usu�rio: ELFASC 
  Senha: qetuo

  URL: http://ws.homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl
  Usuario: elfaws
  Senha: 3lf4ws2501
  /* Atualizar "Tab_CceLayoutConfig" com as credencias acima */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'elfaws', [str_Senha] = '3lf4ws2501' , str_Url = 'http://ws.homologacao.apoiocotacoes.com.br/app/fornecedores/WSFornecedores?wsdl' WHERE [int_IdLayout] = 2


  S�NTESE
  Link do Site: https://www.plataformasintese.com/saude/
  ------------------------------------------------------------
  URL: https://sintese-sandbox.bionexo.com/integrationservice.asmx?wsdl
  Usuario: alfalagos
  Senha: mudar@12345
  /* Atualizar "Tab_CceLayoutConfig" com as credencias acima */ UPDATE [Tab_CceLayoutConfig] SET [str_Usuario] = 'alfalagos', [str_Senha] = 'mudar@12345', str_Url = 'https://sintese-sandbox.bionexo.com/integrationservice.asmx?wsdl' WHERE [int_IdLayout] = 3


  ===================================================================================
   Atualizar Caminhos das Opera��es do CCE
  ===================================================================================
  Atualizar os caminhos para as opera��es WG, WH, WJ, WK e WM do CCE.

  /* Bionexo */ UPDATE [Tab_CceLayoutConfig] SET [str_PathWg] = 'C:\Custom Software\Bionexo\WG', [str_PathWh] = 'C:\Custom Software\Bionexo\WH', [str_PathWj] = 'C:\Custom Software\Bionexo\WJ', [str_PathWk] = 'C:\Custom Software\Bionexo\WK', [str_PathWm] = 'C:\Custom Software\Bionexo\WM' WHERE [int_IdLayout] = 1
  /* Apoio   */ UPDATE [Tab_CceLayoutConfig] SET [str_PathWg] = 'C:\Custom Software\Apoio\WG'  , [str_PathWh] = 'C:\Custom Software\Apoio\WH'  , [str_PathWj] = 'C:\Custom Software\Apoio\WJ'  , [str_PathWk] = 'C:\Custom Software\Apoio\WK'  , [str_PathWm] = 'C:\Custom Software\Apoio\WM'   WHERE [int_IdLayout] = 2
  /* Sintese */ UPDATE [Tab_CceLayoutConfig] SET [str_PathWg] = 'C:\Custom Software\Sintese\WG', [str_PathWh] = 'C:\Custom Software\Sintese\WH', [str_PathWj] = 'C:\Custom Software\Sintese\WJ', [str_PathWk] = 'C:\Custom Software\Sintese\WK', [str_PathWm] = 'C:\Custom Software\Sintese\WM' WHERE [int_IdLayout] = 3

**************************************************************************************/

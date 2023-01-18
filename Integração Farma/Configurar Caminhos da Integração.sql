/**************************************************************************************

  Pressione "[F5]" para utilizar do Script abaixo.
  
  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Confira abaixo tamb�m o Script para criar as pastas automaticamente com o caminho
  que voc� fornecer para n�o ter que criar na m�o. :)

  
  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  CONFIGURAR Integra��es por ARQUIVO
  Execute essa consulta para atualizar as pastas da integra��o da tela de
  configura��o Farma (referente a tabela Tab_FarmaConfig)
  "Menu Superior > Integra��es > Integra��o Farma > Configura��o Farma"

  BEGIN TRAN UPDATE Tab_FarmaConfig
  SET
    [str_DiretorioBackup]     = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Backup'
  , [str_DiretorioEntrada]    = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Entrada'
  , [str_DiretorioErro]       = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Erro'
  , [str_DiretorioNF]         = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\NFE'
  , [str_DiretorioSaida]      = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Saida'
  , [str_DiretorioTemporario] = '<Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\TMP'
  WHERE pk_int_FarmaConfig = PKIntFarmaConfig


  CRIAR PASTAS DA INTEGRA��ES POR ARQUIVO
  Pressione "[Windows] + [R]" e cole o comando abaixo para criar as pastas da
  integra��o (Lembre-se de informar o caminho com "[CTRL] + [SHIFT] + [M]"):
  CMD /c "MD <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Backup <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Entrada <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Erro <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\NFE <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Saida <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\TMP & START <Pasta da Integra��o:, VARCHAR(MAX), C:\FTP\NomeIntegracao>

**************************************************************************************/

-- VER INTEGRA��ES CADASTRADAS
-- As integra��es abaixo est�o dispostas tamb�m na tela de "Configura��o Farma".
-- Menu Superior > Integra��es > Integra��o Farma > Configura��o Farma

-- Integra��es por Token - Web Service
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.str_Descricao, a.str_Url, a.str_Url2, a.str_Token
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 1 ORDER BY a.str_Descricao

-- Integra��es por Arquivo
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_DiretorioBackup, a.str_DiretorioEntrada, a.str_DiretorioErro, a.str_DiretorioSaida, a.str_DiretorioTemporario
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 2 ORDER BY a.str_Descricao

-- Integra��es por WebApi
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_Usuario, a.str_Senha, a.str_ClientSecret
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 3 ORDER BY a.str_Descricao

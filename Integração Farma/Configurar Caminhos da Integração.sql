/**************************************************************************************

  Pressione "[F5]" para utilizar do Script abaixo.
  
  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Confira abaixo também o Script para criar as pastas automaticamente com o caminho
  que você fornecer para não ter que criar na mão. :)

  
  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  CONFIGURAR Integrações por ARQUIVO
  Execute essa consulta para atualizar as pastas da integração da tela de
  configuração Farma (referente a tabela Tab_FarmaConfig)
  "Menu Superior > Integrações > Integração Farma > Configuração Farma"

  BEGIN TRAN UPDATE Tab_FarmaConfig
  SET
    [str_DiretorioBackup]     = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Backup'
  , [str_DiretorioEntrada]    = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Entrada'
  , [str_DiretorioErro]       = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Erro'
  , [str_DiretorioNF]         = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\NFE'
  , [str_DiretorioSaida]      = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Saida'
  , [str_DiretorioTemporario] = '<Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\TMP'
  WHERE pk_int_FarmaConfig = PKIntFarmaConfig


  CRIAR PASTAS DA INTEGRAÇÕES POR ARQUIVO
  Pressione "[Windows] + [R]" e cole o comando abaixo para criar as pastas da
  integração (Lembre-se de informar o caminho com "[CTRL] + [SHIFT] + [M]"):
  CMD /c "MD <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Backup <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Entrada <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Erro <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\NFE <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\Saida <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>\TMP & START <Pasta da Integração:, VARCHAR(MAX), C:\FTP\NomeIntegracao>

**************************************************************************************/

-- VER INTEGRAÇÕES CADASTRADAS
-- As integrações abaixo estão dispostas também na tela de "Configuração Farma".
-- Menu Superior > Integrações > Integração Farma > Configuração Farma

-- Integrações por Token - Web Service
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.str_Descricao, a.str_Url, a.str_Url2, a.str_Token
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 1 ORDER BY a.str_Descricao

-- Integrações por Arquivo
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_DiretorioBackup, a.str_DiretorioEntrada, a.str_DiretorioErro, a.str_DiretorioSaida, a.str_DiretorioTemporario
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 2 ORDER BY a.str_Descricao

-- Integrações por WebApi
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_Usuario, a.str_Senha, a.str_ClientSecret
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 3 ORDER BY a.str_Descricao

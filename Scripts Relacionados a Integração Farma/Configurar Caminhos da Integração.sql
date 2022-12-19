-- Menu Superior > Tabelas > Cadastro > Controle de Integra��es
-- Desativar Config que utiliza Interop Store, e Unilog

-- VER INTEGRA��ES CADASTRADAS
-- Menu Superior > Integra��es > Integra��o Farma > Configura��o Farma
--------------- + --------------- + --------------- + --------------- + ---------------
-- Integra��o por Token - Web Service
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.str_Descricao, a.str_Url, a.str_Url2, a.str_Token
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 1 ORDER BY a.str_Descricao

-- Integra��o por Arquivo
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_DiretorioBackup, a.str_DiretorioEntrada, a.str_DiretorioErro, a.str_DiretorioSaida, a.str_DiretorioTemporario
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 2 ORDER BY a.str_Descricao

-- Integra��o por WebApi
SELECT a.str_Descricao, a.pk_int_FarmaConfig, a.fk_int_FarmaLayouts, a.int_IdEmpresa, a.int_IdLocalEstoque,
a.str_Usuario, a.str_Senha, a.str_ClientSecret
FROM Tab_FarmaConfig AS a WHERE a.int_TipoIntegracao = 3 ORDER BY a.str_Descricao

/**************************************************************************************

-- CONFIGURAR INTEGRA��O POR ARQUIVO
-- Menu Superior > Integra��es > Integra��o Farma > Configura��o Farma
--------------- + --------------- + --------------- + --------------- + ---------------

DECLARE @RootPathIntegracaoFarma AS VARCHAR(50) = '<Caminho Pasta Integra��o Farma, VARCHAR(50), C:\FTP\PDVLink201\>'
BEGIN TRAN UPDATE Tab_FarmaConfig
SET str_DiretorioBackup      = @RootPathIntegracaoFarma + 'Backup',
    str_DiretorioEntrada     = @RootPathIntegracaoFarma + 'Entrada',
    str_DiretorioErro        = @RootPathIntegracaoFarma + 'Erro',
    str_DiretorioNF          = @RootPathIntegracaoFarma + 'NFE',
    str_DiretorioSaida       = @RootPathIntegracaoFarma + 'Saida',
    str_DiretorioTemporario  = @RootPathIntegracaoFarma + 'TMP'
WHERE pk_int_FarmaConfig = '<PkIntFarmaConfig, INT, >'

                        COMMIT                       ROLLBACK

**************************************************************************************/

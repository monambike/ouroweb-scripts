/**************************************************************************************

  ===================================================================================
   Alterar Caminhos Das Pastas (Geração de Arquivos da NFE)
  ===================================================================================

  Execute essa consulta para atualizar as pastas da integração da tela de configuração
  da NFE.
  Isso é útil principalmente quando você precisa atualizar as pastas de uma empresa
  diferente da qual você esteja na NFE no momento.

  BEGIN TRAN UPDATE ConfiguracaoNFE
  SET
    str_DiretorioXMLTrans                    = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXMLError                    = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXMLExport                   = '<Caminho da NFE, , C\NFE\Todos>'
  , str_PathLogoRetrato                      = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioPdfNFE                      = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXMLCanceled                 = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXMLCompra                   = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXMLCCE                      = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXmlNotasInutilizadas        = '<Caminho da NFE, , C\NFE\Todos>'
  , str_DiretorioXmlRetornoNotasInutilizadas = '<Caminho da NFE, , C\NFE\Todos>'
  WHERE fk_int_id_Empresa = @IdEmpresa

                                COMMIT         ROLLBACK                              

**************************************************************************************/

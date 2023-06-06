/**************************************************************************************

  ===================================================================================
   Alterar Caminhos Das Pastas (Gera��o de Arquivos da NFE)
  ===================================================================================

  Execute essa consulta para atualizar as pastas da integra��o da tela de configura��o
  da NFE.
  Isso � �til principalmente quando voc� precisa atualizar as pastas de uma empresa
  diferente da qual voc� esteja na NFE no momento.

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

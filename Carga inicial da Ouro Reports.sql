/**************************************************************************************

  Pressione "[F5]" para utilizar do Script abaixo.
  
  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  O Script à seguir visa auxiliar na carga inciial para a OuroBase.

**************************************************************************************/

EXEC sp_mng_CargaInicial_Estoque  @DatabaseName
EXEC sp_mng_CargaInicial_Cadastro @DatabaseName
EXEC sp_mng_CargaInicial_Pedido   @DatabaseName, 13, 300
EXEC sp_mng_CargaInicial_Saida    @DatabaseName, 02, 300
EXEC sp_mng_CargaInicial_Entrada  @DatabaseName, 08, 300
EXEC sp_mng_CargaInicial_Saida    @DatabaseName, 09, 300
EXEC sp_mng_CargaInicial_Entrada  @DatabaseName, 01, 300
/**************************************************************************************

  Pressione "[F5]" para utilizar do Script abaixo.
  
  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  O Script à seguir visa auxiliar a realizar cargas de alguns dados da OuroBase para
  a OuroReports.
  Informe o nome da base e rode o Script para realizar as cargas.

**************************************************************************************/

DECLARE @DatabaseName AS SYSNAME = '<Nome da Base, SYSNAME, >'
EXEC sp_mng_CargaInicial_Estoque  @DatabaseName
EXEC sp_mng_CargaInicial_Cadastro @DatabaseName
EXEC sp_mng_CargaInicial_Pedido   @DatabaseName, 13, 300
EXEC sp_mng_CargaInicial_Saida    @DatabaseName, 02, 300
EXEC sp_mng_CargaInicial_Entrada  @DatabaseName, 08, 300
EXEC sp_mng_CargaInicial_Saida    @DatabaseName, 09, 300
EXEC sp_mng_CargaInicial_Entrada  @DatabaseName, 01, 300
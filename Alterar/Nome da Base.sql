/*********************************************************************

  LEGENDA

  Pressione CTRL + SHIFT + M para definir os par�metros e valores util
  izado nesse template.
  
  Parameter: � a coluna que cont�m o nome do par�metro ou o que ele fa
  z;
  Type: � o valor que pode ser inserido no par�metro;
  Value: � onde voc� deve inserir o valor desejado.

  
  ATEN��O
  
  Esse Script colocar� a base em modo de usu�rio �nico (desconectando 
  todos os usu�rios e derrubando conex�es) e alterar� o seu nome.
  
*********************************************************************/

USE master
GO

ALTER DATABASE <Nome da base antiga, VARCHAR, >
  SET SINGLE_USER WITH ROLLBACK IMMEDIATE
PRINT
(
  'Todos os usu�rios, exceto voc�, foram desconectados da base "Teste". No momento voc� � o �nico ' + CHAR(13) + CHAR(10) +
  'usu�rio conectado e outros usu�rios n�o poder�o se conectar at� o acesso ser liberado' + CHAR(13) + CHAR(10) +
  'novamente.' + CHAR(13) + CHAR(10)
)
GO

EXEC master..sp_renamedb  <Nome da base antiga, VARCHAR, >,  <Nome da base nova, VARCHAR, >
PRINT CHAR(13) + CHAR(10) + 'A base "<Nome da base antiga, VARCHAR, >" teve seu nome alterado para "<Nome da base nova, VARCHAR, >".'
GO

ALTER DATABASE <Nome da base nova, VARCHAR, >
  SET MULTI_USER
PRINT CHAR(13) + CHAR(10) + 'O acesso � base foi liberado. Novos usu�rios poder�o se conectar novamente � base.'
GO

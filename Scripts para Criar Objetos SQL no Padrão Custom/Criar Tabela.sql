/**********************************************************************
  [APAGUE ESSE COMENT�RIO] Sugest�o de Nome do Script: XXX - Criar_Tabela_Tab_<Nome da Tabela, , >
  [APAGUE ESSE COMENT�RIO] Pressione CTRL + SHIFT + M para definir os par�metros
  [APAGUE ESSE COMENT�RIO] e valores utilizado nesse template.

  Nome da Tabela: Tab_<Nome da Tabela, , >

  Descri��o: <(N�o Obrigat�rio) Breve descri��o de para que serve essa tabela, , >

  OBS: <(N�o Obrigat�rio) Telas onde � usada e outras informa��es e anota��es adicionais, , >

**********************************************************************/

IF NOT EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'Tab_<Nome da Tabela, , >')
  BEGIN
    PRINT 'Criando a tabela "Tab_<Nome da Tabela, , >"...'

    CREATE TABLE Tab_<Nome da Tabela, , >
    (
      pk_int_<Nome da Tabela, , > INT NOT NULL IDENTITY(1,1),
      constraint PK_Tab_<Nome da Tabela, , > PRIMARY KEY (pk_int_<Nome da Tabela, , >)
    )
    
  END
GO

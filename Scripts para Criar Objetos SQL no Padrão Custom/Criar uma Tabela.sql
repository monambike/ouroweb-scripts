-- [APAGUE ESSE COMENT�RIO] (Dica: Pressione "CTRL + SHIFT + M")
/**********************************************************************

  Nome da Tabela: Tab_<Nome da Tabela, , >
  Sugest�o de Nome do Script: XXX - Criar_Tabela_<Nome da Tabela, , >

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

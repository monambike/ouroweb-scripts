/**********************************************************************
  [APAGUE ESSE COMENTÁRIO] Sugestão de Nome do Script: XXX - Criar_Tabela_Tab_<Nome da Tabela, , >
  [APAGUE ESSE COMENTÁRIO] Pressione CTRL + SHIFT + M para definir os parâmetros
  [APAGUE ESSE COMENTÁRIO] e valores utilizado nesse template.

  Nome da Tabela: Tab_<Nome da Tabela, , >

  Descrição: <(Não Obrigatório) Breve descrição de para que serve essa tabela, , >

  OBS: <(Não Obrigatório) Telas onde é usada e outras informações e anotações adicionais, , >

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

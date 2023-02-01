-- [APAGUE ESSE COMENTÁRIO] (Dica: Pressione "CTRL + SHIFT + M")
/**********************************************************************

  Nome da Tabela: <Nome da Tabela, , >
  Sugestão de Nome do Script: XXX - Alterar_Tabela_<Nome da Tabela, , >

  Nome da Coluna: <Nome da Coluna, , >

**********************************************************************/

IF NOT EXISTS (SELECT * FROM SYSCOLUMNS WHERE ID = OBJECT_ID('<Nome da Tabela, , >') AND NAME IN('<Nome da Coluna, , >'))
  BEGIN
    PRINT 'Criando a(s) colunas(s) "<Nome da Coluna, , >"...'

    -- Criar Bit
    ALTER TABLE <Nome da Tabela, , >
      ADD <Nome da Coluna, , > BIT NOT NULL CONSTRAINT DF_<Nome da Tabela, , >_<Nome da Coluna, , > DEFAULT 0
  END
GO

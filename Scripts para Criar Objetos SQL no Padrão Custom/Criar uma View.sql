-- [APAGUE ESSE COMENTÁRIO] Pressione "CTRL + SHIFT + M"
/*************************************************************************************

  Nome da Tabela: <Nome da View, , >
  Sugestão de Nome do Script: XXX - Criar_View_<Nome da View, , >

  Descrição: <Breve descrição de para que serve essa view, , >

  OBS: <(Não Obrigatório) Telas onde é usada e outras informações e anotações adicionais, , >

**************************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'V' AND NAME = 'uvw_<Nome da View, , >')
  BEGIN
    PRINT 'Removendo a view "uvw_<Nome da View, , >"...'
      DROP VIEW uvw_<Nome da View, , >
  END
GO

PRINT 'Criando a view "uvw_<Nome da View, , >"...'
GO

CREATE VIEW uvw_<Nome da View, , >
AS

/* Colocar código que estará dentro da view substituindo esse comentário */
GO

GRANT SELECT ON uvw_<Nome da View, , > TO PUBLIC
GO

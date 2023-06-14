/* [APAGUE ESSE COMENTÁRIO] (Dica: Pressione "CTRL + SHIFT + M") */
/*************************************************************************************

  Nome da View: uvw_<Nome da View, , >
  Sugestão de Nome do Script: XXX - Criar_View_uvw_<Nome da View, , >

  Descrição: <(Opcional) Breve descrição de para que serve ou onde é chamado, , >

  OBS: <(Opcional) Outras informações relevantes e anotações adicionais, , >

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

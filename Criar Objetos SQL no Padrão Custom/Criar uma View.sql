/* [APAGUE ESSE COMENT�RIO] (Dica: Pressione "CTRL + SHIFT + M") */
/*************************************************************************************

  Nome da View: uvw_<Nome da View, , >
  Sugest�o de Nome do Script: XXX - Criar_View_uvw_<Nome da View, , >

  Descri��o: <(Opcional) Breve descri��o de para que serve ou onde � chamado, , >

  OBS: <(Opcional) Outras informa��es relevantes e anota��es adicionais, , >

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

/* Colocar c�digo que estar� dentro da view substituindo esse coment�rio */

GO

GRANT SELECT ON uvw_<Nome da View, , > TO PUBLIC
GO

-- [APAGUE ESSE COMENT�RIO] Pressione "CTRL + SHIFT + M"
/*************************************************************************************

  Nome da Tabela: <Nome da View, , >
  Sugest�o de Nome do Script: XXX - Criar_View_<Nome da View, , >

  Descri��o: <Breve descri��o de para que serve essa view, , >

  OBS: <(N�o Obrigat�rio) Telas onde � usada e outras informa��es e anota��es adicionais, , >

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

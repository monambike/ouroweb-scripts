-- [APAGUE ESSE COMENT�RIO] (Dica: Pressione "CTRL + SHIFT + M")
/**********************************************************************

  Nome da Procedure: usp_<Nome da Procedure, , >
  Sugest�o de Nome do Script: XXX - Criar_Procedure_<Nome da Procedure, , >

  Descri��o: <(Opcional) Breve descri��o de para que serve essa procedure, , >

  OBS: <(Opcional) Telas e lugares onde � usada e outras informa��es e anota��es adicionais, , >

**********************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'P' AND NAME = 'usp_<Nome da Procedure, , >')
  BEGIN
    PRINT 'Removendo procedure "usp_<Nome da Procedure, , >"...'
    DROP PROCEDURE usp_<Nome da Procedure, , >
  END
GO

PRINT 'Criando procedure "usp_<Nome da Procedure, , >"...'
GO

CREATE PROCEDURE usp_<Nome da Procedure, , >
AS

/* Colocar c�digo do conte�do da procedure substituindo esse coment�rio */

GRANT EXEC ON usp_<Nome da Procedure, , > TO PUBLIC
GO

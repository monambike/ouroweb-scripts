-- [APAGUE ESSE COMENT�RIO] Pressione "CTRL + SHIFT + M"
/******************************************************************************

  Nome da Tabela: <Nome da Fun��o, , >
  Sugest�o de Nome do Script: XXX - Criar_Funcao_<Nome da Fun��o, , >

  Descri��o: <Breve descri��o de para que serve essa fun��o, , >

*******************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'TF' AND NAME = 'ufn_<Nome da Fun��o, , >')
  BEGIN
    PRINT 'Removendo fun��o "ufn_<Nome da Fun��o, , >"...'
    DROP FUNCTION ufn_<Nome da Fun��o, , >
  END
GO

PRINT 'Criando fun��o "ufn_<Nome da Fun��o, , >"...'
GO

CREATE FUNCTION ufn_<Nome da Fun��o, , >()
RETURNS INT
AS
  BEGIN

    /* Colocar c�digo que estar� dentro da fun��o substituindo esse coment�rio */

  RETURN 0
END
GO

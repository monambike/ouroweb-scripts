/* [APAGUE ESSE COMENT�RIO] (Dica: Pressione "CTRL + SHIFT + M") */
/******************************************************************************

  Nome da Fun��o: ufn_<Nome da Fun��o, , >
  Sugest�o de Nome do Script: XXX - Criar_Funcao_ufn_<Nome da Fun��o, , >

  Descri��o: <(Opcional) Breve descri��o de para que serve ou onde � chamado, , >

  OBS: <(Opcional) Outras informa��es relevantes e anota��es adicionais, , >

*******************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE IN ('FN', 'TF') AND NAME = 'ufn_<Nome da Fun��o, , >')
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

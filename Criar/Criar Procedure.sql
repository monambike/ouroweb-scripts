/**********************************************************************

    Nome da Procedure: usp_<Nome da Procedure, , >

    Descri��o: <Breve descri��o de para que serve essa procedure, , >
			
		OBS: <(N�o Obrigat�rio) Telas e lugares onde � usada e outras informa��es e anota��es adicionais, , >
			
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

/* Colocar c�digo de cria��o da procedure substituindo esse coment�rio */

GRANT EXEC ON usp_<Nome da Procedure, , > TO PUBLIC
GO

/**********************************************************************

    Nome da Tabela: tr_<Nome da Trigger, , >

    Descri��o: <Breve descri��o de para que serve essa Trigger, , >

    OBS: <(N�o Obrigat�rio) Telas onde � usada e outras informa��es e anota��es adicionais, , >

**********************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'TR' AND NAME = 'tr_<Nome da Trigger, , >')
  BEGIN
    PRINT 'Removendo a Trigger "tr_<Nome da Trigger, , >"...'
    DROP TRIGGER tr_<Nome da Trigger, , >
  END
GO

PRINT 'Criando a Trigger "tr_<Nome da Trigger, , >"...'
GO

CREATE TRIGGER tr_<Nome da Trigger, , >
ON <Nome da Tabela ou View, , >
FOR <Tipo de a��o que disparar� a Trigger, , INSERT UPDATE, DELETE>
AS

/* Colocar c�digo que estar� dentro da trigger substituindo esse coment�rio */

GO

GRANT EXEC ON tr_<Nome da Trigger, , > TO PUBLIC

GO

/**********************************************************************

    Nome da Tabela: tr_<Nome da Trigger, , >

    Descrição: <Breve descrição de para que serve essa Trigger, , >

    OBS: <(Não Obrigatório) Telas onde é usada e outras informações e anotações adicionais, , >

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
FOR <Tipo de ação que disparará a Trigger, , INSERT UPDATE, DELETE>
AS

/* Colocar código que estará dentro da trigger substituindo esse comentário */

GO

GRANT EXEC ON tr_<Nome da Trigger, , > TO PUBLIC

GO

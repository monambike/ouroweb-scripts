/**********************************************************************
  [APAGUE ESSE COMENTÁRIO] Sugestão de Nome do Script: XXX - Criar_Tabela_Tab_<Nome da Tabela, , >
  [APAGUE ESSE COMENTÁRIO] Pressione CTRL + SHIFT + M para definir os parâmetros
  [APAGUE ESSE COMENTÁRIO] e valores utilizado nesse template.

  Nome da Procedure: usp_<Nome da Procedure, , >

  Descrição: <(Não Obrigatório) Breve descrição de para que serve essa procedure, , >

  OBS: <(Não Obrigatório) Telas e lugares onde é usada e outras informações e anotações adicionais, , >

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

/* Colocar código de criação da procedure substituindo esse comentário */

GRANT EXEC ON usp_<Nome da Procedure, , > TO PUBLIC
GO

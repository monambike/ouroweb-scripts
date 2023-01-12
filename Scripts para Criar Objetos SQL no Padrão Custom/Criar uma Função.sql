-- [APAGUE ESSE COMENTÁRIO] Pressione "CTRL + SHIFT + M"
/******************************************************************************

  Nome da Tabela: <Nome da Função, , >
  Sugestão de Nome do Script: XXX - Criar_Funcao_<Nome da Função, , >

  Descrição: <Breve descrição de para que serve essa função, , >

*******************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE = 'TF' AND NAME = 'ufn_<Nome da Função, , >')
  BEGIN
    PRINT 'Removendo função "ufn_<Nome da Função, , >"...'
    DROP FUNCTION ufn_<Nome da Função, , >
  END
GO

PRINT 'Criando função "ufn_<Nome da Função, , >"...'
GO

CREATE FUNCTION ufn_<Nome da Função, , >()
RETURNS INT
AS
  BEGIN

    /* Colocar código que estará dentro da função substituindo esse comentário */

  RETURN 0
END
GO

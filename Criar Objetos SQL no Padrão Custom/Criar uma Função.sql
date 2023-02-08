/* [APAGUE ESSE COMENTÁRIO] (Dica: Pressione "CTRL + SHIFT + M") */
/******************************************************************************

  Nome da Função: ufn_<Nome da Função, , >
  Sugestão de Nome do Script: XXX - Criar_Funcao_ufn_<Nome da Função, , >

  Descrição: <(Opcional) Breve descrição de para que serve ou onde é chamado, , >

  OBS: <(Opcional) Outras informações relevantes e anotações adicionais, , >

*******************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE IN ('FN', 'TF') AND NAME = 'ufn_<Nome da Função, , >')
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

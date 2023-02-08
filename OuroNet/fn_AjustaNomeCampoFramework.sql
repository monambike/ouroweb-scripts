/******************************************************************************

  Nome da Função: AjustaNomeCampoFramework
  Sugestão de Nome do Script: XXX - Criar_Funcao_AjustaNomeCampoFramework

  Descrição: Script para auxiliar na execução das procedures referentes ao
  mapeamento de objetos do SQL Server para o "OuroNet".

*******************************************************************************/

IF EXISTS (SELECT * FROM SYSOBJECTS WHERE TYPE IN ('FN', 'TF') AND NAME = 'AjustaNomeCampoFramework')
  BEGIN
    PRINT 'Removendo função "AjustaNomeCampoFramework"...'
    DROP FUNCTION AjustaNomeCampoFramework
  END
GO

PRINT 'Criando função "AjustaNomeCampoFramework"...'
GO

CREATE FUNCTION AjustaNomeCampoFramework
(
  @Field      VARCHAR(MAX),
  @FieldIsBit bit = 0
) RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Result VARCHAR(MAX)
  
  SET @Result = dbo.RemoveAcentos(@Field)

  SET @Result = (CASE SUBSTRING(@Result, 1, 4)
                   WHEN 'bit_' THEN REPLACE(@Result,'bit_', '')
                   WHEN 'cur_' THEN REPLACE(@Result,'cur_', '')
                   WHEN 'dbl_' THEN REPLACE(@Result,'dbl_', '')
                   WHEN 'dte_' THEN REPLACE(@Result,'dte_', '')
                   WHEN 'int_' THEN REPLACE(@Result,'int_', '')
                   WHEN 'str_' THEN REPLACE(@Result,'str_', '')
                   WHEN 'img_' THEN REPLACE(@Result,'img_', '')
                   ELSE @Result
                 END)
  
  SET @Result = REPLACE(@Result,'_', '')
  SET @Result = REPLACE(@Result,'fkint', 'FkInt')
  SET @Result = REPLACE(@Result,'pkint', 'PkInt')
  
  IF (@FieldIsBit = 1)
    SET @Result = '_' + LOWER(LEFT(@Result, 1)) + SUBSTRING(@Result, 2, LEN(@Result))

  return @Result
END
GO

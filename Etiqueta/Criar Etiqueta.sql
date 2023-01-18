/**********************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e parâmetros a serem utilizados
  nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Template para ajudar na criação de novas etiquetas no sistema.


  ===================================================================================
   Auxiliary Commands
  ===================================================================================

  Tabelas relacionadas à criação da etiqueta:
  SELECT * FROM Tab_Etiqueta
  SELECT * FROM Tab_EtiquetaMod 
  SELECT * FROM tab_ConfigMod

**********************************************************************/

BEGIN TRAN
  IF EXISTS (SELECT * FROM Tab_Etiqueta WHERE str_nm_Etiqueta = '<Nome da Etiqueta, VARCHAR(MAX), >')
    BEGIN
      PRINT 'Esta etiqueta já foi inserida anteriormente no banco de dados.'
    END
  ELSE
    BEGIN
      PRINT 'Inserindo a etiqueta "<Nome da Etiqueta, VARCHAR(MAX), >" na tabela "Tab_Etiqueta"...'
      INSERT INTO [dbo].[Tab_Etiqueta]
      ( 
        int_nro_Etiqueta
      , str_nm_Etiqueta
      , fk_int_Empresa
      , bit_Ativo
      , bit_Default
      )
      SELECT
        'int_nro_Etiqueta' = <Número da Etiqueta, INT, >
      , 'str_nm_Etiqueta'  = '<Nome da Etiqueta, VARCHAR(MAX), >'
      , 'int_IdEmpresa'    = [IdEmpresa]
      , 'bit_Ativo'        = 1
      , 'bit_Default'      = 0
      FROM [Tab_Empresa]
    END

  IF NOT EXISTS(SELECT fk_int_ConfigMod, fk_int_Etiqueta FROM Tab_EtiquetaMod WHERE fk_int_Etiqueta = (SELECT TOP 1 pk_Etiqueta FROM Tab_Etiqueta WHERE str_nm_Etiqueta = '  <Nome da Etiqueta, VARCHAR(MAX), >') AND fk_int_ConfigMod = (SELECT pk_int_ConfigMod from tab_ConfigMod where str_NomeMod = '<Nome do Módulo da Etiqueta, VARCHAR(MAX), >'))
    BEGIN
      INSERT INTO
      Tab_EtiquetaMod 
      (
        fk_int_ConfigMod
      , fk_int_Etiqueta
      )
      SELECT
        (SELECT pk_int_ConfigMod FROM tab_ConfigMod WHERE str_NomeMod = '<Nome do Módulo da Etiqueta, VARCHAR(MAX), >') AS pk_int_ConfigMod
      , pk_Etiqueta 
      FROM
        Tab_Etiqueta
      WHERE
        str_nm_Etiqueta = '<Nome da Etiqueta, VARCHAR(MAX), >'
    END
COMMIT TRAN
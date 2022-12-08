SELECT
  b.str_NomeMod,
  a.pk_int_ConfigCampoMod,
  a.fk_int_ConfigMod,
  a.fk_int_ConfigCampo,
  c.str_NomeCampo,
  c.str_DescricaoCampo
FROM
  tab_ConfigCampoMod AS a
    INNER JOIN
  tab_ConfigMod AS b
      ON a.fk_int_ConfigMod = b.pk_int_ConfigMod
    INNER JOIN
  tab_ConfigCampo AS c
      ON c.pk_int_ConfigCampo = a.fk_int_ConfigCampo
--WHERE str_NomeCampo LIKE ('%NaoConsideraMovDtVencFeriadoNoTotalAVencer%')

/*


BEGIN TRAN DELETE FROM tab_ConfigCampoMod WHERE pk_int_ConfigCampoMod IN(715, 716)


           COMMIT             ROLLBACK
           
           
*/
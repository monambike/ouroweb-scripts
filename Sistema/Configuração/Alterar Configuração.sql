SELECT * FROM TAB_CONFIGCAMPO WHERE str_NomeCampo = 'bln_IntegraCotacaoEletronicaConsolidada'

SELECT * FROM tab_ConfigCampoAtributo WHERE fk_int_ConfigCampo = 494 

update tab_ConfigCampoAtributo 
set str_ValorAtributo = 1
WHERE fk_int_ConfigCampo = 494 
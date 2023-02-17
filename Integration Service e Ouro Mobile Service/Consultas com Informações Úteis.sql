/**************************************************************************************

  Pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script serve como aux�lio no desenvolvimento para as pend�ncias que utilizam
  do "Integration Service" e "Mobile Service".


  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  Ver erros referentes ao servi�o:
  SELECT * FROM LogData
  SELECT * FROM LogMovimento

  SELECT * FROM TipoIntegracaoTransacao

  Ver movimentos prontos para serem integrados:
  SELECT * FROM Comun_Mov_Estoque

**************************************************************************************/

SELECT
  CASE WHEN str_IdFuncionario IS NULL THEN CAST([Empresa].[IdEmpresa] AS VARCHAR) ELSE [Funcionario].[IdFuncion�rio] END AS [ID (OuroBase)]
, CASE WHEN str_IdFuncionario IS NULL THEN [Empresa].[Empresa] ELSE [Funcionario].[NOME] END                             AS [Nome (OuroBase)]
, [EntidadeDaIntegracao].[int_IdEmpresaIntegracao]                                                                       AS [ID (Base da Integra��o)]
, CASE WHEN [EntidadeDaIntegracao].fk_int_IdEmpresaLocal <> 0 THEN [EntidadeDaIntegracao].fk_int_IdEmpresaLocal ELSE NULL END AS [LocalEstoqueID (Base da Integra��o)]
, [EntidadeDaIntegracao].[str_DescricaoEmpresa]                                                                          AS [Nome (Base da Integra��o)]
, CASE WHEN str_IdFuncionario IS NULL THEN 'Empresa' ELSE 'Funcion�rio (Representante)' END                              AS [Tipo de Registro]
, CASE WHEN str_IdFuncionario IS NULL THEN 'Tab_Empresa' ELSE 'Tab_Funcion�rios' END                                     AS [Tabela]
FROM
  [Tab_Empresa_Integracao] AS [EntidadeDaIntegracao]
    LEFT JOIN
  [Tab_Empresa]            AS [Empresa]      ON [EntidadeDaIntegracao].[fk_int_IdEmpresaLocal] <> 0    AND [Empresa].[IdEmpresa]            = [EntidadeDaIntegracao].[int_IdEmpresaIntegracao]
    LEFT JOIN
  [Tab_LocaisEstoque]      AS [LocalEstoque] ON [EntidadeDaIntegracao].[fk_int_IdEmpresaLocal] <> 0    AND [LocalEstoque].[IdLocal]         = [EntidadeDaIntegracao].[fk_int_IdEmpresaLocal]
    LEFT JOIN
  [Tab_Funcion�rios]       AS [Funcionario]  ON [EntidadeDaIntegracao].[str_IdFuncionario] IS NOT NULL AND [Funcionario].[IdFuncion�rio] = [EntidadeDaIntegracao].[str_IdFuncionario]
ORDER BY
  [Tipo de Registro]
, [Nome (OuroBase)]

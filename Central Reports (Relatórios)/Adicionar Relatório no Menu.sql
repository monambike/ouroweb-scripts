/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e par�metros a serem utilizados
  nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a atualiza��o ou inclus�o de um relat�rio no
  menu de relat�rio (Relat�rios Gerais).


  ===================================================================================
   Filtros Selecionados
  ===================================================================================

  Nome do Relat�rio:      "<Nome do Relat�rio, NVARCHAR, >"
  Descri��o do Relat�rio: "<Descri��o do Relat�rio, NVARCHAR, >"
  Nome do grupo:          "<Nome do Grupo do Relat�rio, NVARCHAR, >"

**************************************************************************************/

DECLARE
  @NomeRelatorio      AS NVARCHAR(MAX) = '<Nome do Relat�rio         , VARCHAR(MAX), >'
, @DescricaoRelatorio AS NVARCHAR(MAX) = '<Descri��o do Relat�rio    , VARCHAR(MAX), >'
, @NomeGrupo          AS NVARCHAR(MAX) = '<Nome do Grupo do Relat�rio, VARCHAR(MAX), >'

DECLARE @IdRelatorioGrupo AS INT = (SELECT [IdRelatorioGrupo] FROM [Tab_Relatorios] WHERE  [Descricao] = @NomeGrupo)
-- Tabela "Tab_Relatorios".
DELETE FROM [Tab_Relatorios] WHERE ([NomeRelatorio] = @NomeRelatorio)
INSERT INTO [Tab_Relatorios] ([NomeRelatorio], [Descricao], [IdRelatorioGrupo], [Ativo])
VALUES (@NomeRelatorio, @DescricaoRelatorio, @IdRelatorioGrupo, 1)
-- Tabela "Tab_Se��esReports".
DELETE FROM [Tab_Se��esReports] WHERE ([NomeReport] = @NomeRelatorio)
INSERT INTO [Tab_Se��esReports] ([NomeReport], [IdSe��oReport])
VALUES (@NomeRelatorio, 0)


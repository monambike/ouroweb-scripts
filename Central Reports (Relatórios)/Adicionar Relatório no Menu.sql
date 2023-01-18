/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e parâmetros a serem utilizados
  nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a atualização ou inclusão de um relatório no
  menu de relatório (Relatórios Gerais).


  ===================================================================================
   Filtros Selecionados
  ===================================================================================

  Nome do Relatório:      "<Nome do Relatório, NVARCHAR, >"
  Descrição do Relatório: "<Descrição do Relatório, NVARCHAR, >"
  Nome do grupo:          "<Nome do Grupo do Relatório, NVARCHAR, >"

**************************************************************************************/

DECLARE
  @NomeRelatorio      AS NVARCHAR(MAX) = '<Nome do Relatório         , VARCHAR(MAX), >'
, @DescricaoRelatorio AS NVARCHAR(MAX) = '<Descrição do Relatório    , VARCHAR(MAX), >'
, @NomeGrupo          AS NVARCHAR(MAX) = '<Nome do Grupo do Relatório, VARCHAR(MAX), >'

DECLARE @IdRelatorioGrupo AS INT = (SELECT [IdRelatorioGrupo] FROM [Tab_Relatorios] WHERE  [Descricao] = @NomeGrupo)
-- Tabela "Tab_Relatorios".
DELETE FROM [Tab_Relatorios] WHERE ([NomeRelatorio] = @NomeRelatorio)
INSERT INTO [Tab_Relatorios] ([NomeRelatorio], [Descricao], [IdRelatorioGrupo], [Ativo])
VALUES (@NomeRelatorio, @DescricaoRelatorio, @IdRelatorioGrupo, 1)
-- Tabela "Tab_SeçõesReports".
DELETE FROM [Tab_SeçõesReports] WHERE ([NomeReport] = @NomeRelatorio)
INSERT INTO [Tab_SeçõesReports] ([NomeReport], [IdSeçãoReport])
VALUES (@NomeRelatorio, 0)


/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e parâmetros a serem utilizados
  nesse template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a atualização ou inclusão de um relatório no
  menu de relatório (Relatórios Gerais).


  SELECTED PARAMETERS (UPDATE)
  -------------------------------------------------------------------------------------
  Nome do Relatório:      "<Nome do Relatório, NVARCHAR, >"
  Descrição do Relatório: "<Descrição do Relatório, NVARCHAR, >"
  Nome do grupo:          "<Nome do Grupo do Relatório, NVARCHAR, >"

**************************************************************************************/

DECLARE
  @NomeRelatorio      AS NVARCHAR(MAX) = '<Nome do Relatório, NVARCHAR, >',
  @DescricaoRelatorio AS NVARCHAR(MAX) = '<Descrição do Relatório, NVARCHAR, >',
  @NomeGrupo          AS NVARCHAR(MAX) = '<Nome do Grupo do Relatório, NVARCHAR, >'

DECLARE @IdRelatorioGrupo AS INT = (SELECT
                                      [IdRelatorioGrupo]
                                    FROM 
                                      [Tab_Relatorios] 
                                    WHERE  
                                      [Descricao] = @NomeGrupo)


DELETE FROM [Tab_Relatorios] WHERE ([NomeRelatorio] = @NomeRelatorio)
INSERT INTO [Tab_Relatorios] ([NomeRelatorio], [Descricao], [IdRelatorioGrupo], [Ativo])
VALUES (@NomeRelatorio, @DescricaoRelatorio, @IdRelatorioGrupo, 1)

DELETE FROM [Tab_SeçõesReports] WHERE ([NomeReport] = @NomeRelatorio)
INSERT INTO [Tab_SeçõesReports] ([NomeReport], [IdSeçãoReport]) VALUES (@NomeRelatorio, 0)


/**************************************************************************************

  Pressione [CTRL]+[SHIFT]+[M] para definir os valores e par�metros a serem utilizados
  nesse template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a atualiza��o ou inclus�o de um relat�rio no
  menu de relat�rio (Relat�rios Gerais).


  SELECTED PARAMETERS (UPDATE)
  -------------------------------------------------------------------------------------
  Nome do Relat�rio:      "<Nome do Relat�rio, NVARCHAR, >"
  Descri��o do Relat�rio: "<Descri��o do Relat�rio, NVARCHAR, >"
  Nome do grupo:          "<Nome do Grupo do Relat�rio, NVARCHAR, >"

**************************************************************************************/

DECLARE
  @NomeRelatorio      AS NVARCHAR(MAX) = '<Nome do Relat�rio, NVARCHAR, >',
  @DescricaoRelatorio AS NVARCHAR(MAX) = '<Descri��o do Relat�rio, NVARCHAR, >',
  @NomeGrupo          AS NVARCHAR(MAX) = '<Nome do Grupo do Relat�rio, NVARCHAR, >'

DECLARE @IdRelatorioGrupo AS INT = (SELECT
                                      [IdRelatorioGrupo]
                                    FROM 
                                      [Tab_Relatorios] 
                                    WHERE  
                                      [Descricao] = @NomeGrupo)


DELETE FROM [Tab_Relatorios] WHERE ([NomeRelatorio] = @NomeRelatorio)
INSERT INTO [Tab_Relatorios] ([NomeRelatorio], [Descricao], [IdRelatorioGrupo], [Ativo])
VALUES (@NomeRelatorio, @DescricaoRelatorio, @IdRelatorioGrupo, 1)

DELETE FROM [Tab_Se��esReports] WHERE ([NomeReport] = @NomeRelatorio)
INSERT INTO [Tab_Se��esReports] ([NomeReport], [IdSe��oReport]) VALUES (@NomeRelatorio, 0)


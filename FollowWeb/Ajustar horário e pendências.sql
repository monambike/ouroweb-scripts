/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.

  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar o ajuste de pendências e horários de
  apontamento no Follow.

**************************************************************************************/

DECLARE
  @IdUsuario   AS INT      = 1226 -- (Meu usuário)
, @IdPendencia AS INT      = ''
, @Data        AS DATETIME = ''   -- Formato da Data [yyyy-MM-dd]

SELECT
  [pendenciahora].[IdPendenciaHoras] AS [IdPendenciaHoras]
, [node].[Descricao]                 AS [Pendência na Pasta]
, [usuario].[PrimeiroNome]           AS [PrimeiroNome]
, [usuario].[Email]                  AS [Email]
, [pendenciahora].[IdPendencia]      AS [IdPendencia]
, [pendencia].[Assunto]              AS [Assunto]
, [tipohora].[DescricaoTipoHora]     AS [DescricaoTipoHora]
, [pendenciahora].[Data]             AS [Data]
, [pendenciahora].[HoraInicio]       AS [HoraInicio]
, [pendenciahora].[HoraFim]          AS [HoraFim]
FROM
  [Pendencias_Horas] AS [pendenciahora] WITH(NOLOCK)
  INNER JOIN
  [Usuarios]         AS [usuario]       WITH(NOLOCK) ON [pendenciahora].[IdUsuarioResp] = [usuario].[IdUsuario]
  INNER JOIN
  [Pendencias]       AS [pendencia]     WITH(NOLOCK) ON [pendenciahora].[IdPendencia]   = [pendencia].[IdPendencia]
  INNER JOIN
  [Tipo_Horas]       AS [tipohora]      WITH(NOLOCK) ON [pendenciahora].[IdTipoHora]    = [tipohora].[IdTipoHora]
  INNER JOIN
  [Nodes]            AS [node]          WITH(NOLOCK) ON [node].[IdNode]                 = [pendencia].[IdNode]
WHERE
  ([pendenciahora].IdUsuarioResp = @IdUsuario)
  AND (@IdPendencia = '' OR [pendenciahora].IdPendencia = @IdPendencia)
  AND ((@Data = '' AND FORMAT(GETDATE(), 'yyyy-MM-dd') = [pendenciahora].Data) OR (@Data = [pendenciahora].Data))
ORDER BY CAST([pendenciahora].[HoraInicio] AS TIME)

/**************************************************************************************

  [Visualizar Tipos de Hora]
  SELECT [IdTipoHora], [DescricaoTipoHora], [Ativo] FROM Tipo_Horas WITH(NOLOCK)
  WHERE [IdTipoHora] IN (4,6,8,10,14,17,28,33) ORDER BY DescricaoTipoHora


  [DELETAR HORA]
  BEGIN TRAN DELETE FROM Pendencias_Horas WHERE IdPendenciaHoras = '<(Alterar) ID do Registro de Hora da Pendência, INT, >'

  [ATUALIZAR APONTAMENTO]
  [Atualizar Hora]
  BEGIN TRAN UPDATE Pendencias_Horas SET HoraInicio = '1900-01-01 14:17:43.000' WHERE IdPendenciaHoras = '<(Alterar) ID do Registro de Hora da Pendência, INT, >'
  BEGIN TRAN UPDATE Pendencias_Horas SET HoraFim = '1899-12-30 15:41:12.000' WHERE IdPendenciaHoras = '<(Alterar) ID do Registro de Hora da Pendência, INT, >'
  [Atualizar Tipo Apontamento]
  BEGIN TRAN UPDATE Pendencias_Horas SET IdTipoHora = 6 WHERE IdPendenciaHoras = '<(Alterar) ID do Registro de Hora da Pendência, INT, >'


  [ATUALIZAR PENDENCIA]
  [Trocar a Pasta]
  BEGIN TRAN UPDATE Pendencias SET IdNode = 1656 WHERE IdPendencia = '<(Alterar) ID da Pendência, INT, >'


                              COMMIT            ROLLBACK                               

/**************************************************************************************
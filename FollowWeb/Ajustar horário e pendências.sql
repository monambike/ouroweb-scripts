DECLARE
    @IdUsuario AS INT   = 1226 -- Meu usuário
  , @IdPendencia AS INT = ''
  , @Data AS DATETIME   = ''   -- Formato [yyyy-MM-dd]

SELECT
    [pendenciahora].IdPendenciaHoras
  , [usuario].IdUsuario
  , [usuario].PrimeiroNome
  , [usuario].Email
  , [pendenciahora].IdPendencia
  , [pendencia].Assunto
  , [tipohora].DescricaoTipoHora
  , [pendenciahora].Data
  , [pendenciahora].HoraInicio
  , [pendenciahora].HoraFim
FROM
  [Pendencias_Horas] AS [pendenciahora] WITH(NOLOCK)
    INNER JOIN
  [Usuarios] AS [usuario] WITH(NOLOCK)
      ON [pendenciahora].[IdUsuarioResp] = [usuario].[IdUsuario]
    INNER JOIN
  [Pendencias] AS [pendencia] WITH(NOLOCK)
      ON [pendenciahora].[IdPendencia] = [pendencia].[IdPendencia]
    INNER JOIN
  Tipo_Horas AS [tipohora] WITH(NOLOCK)
      ON [pendenciahora].[IdTipoHora] = [tipohora].[IdTipoHora]
WHERE
  ([pendenciahora].IdUsuarioResp = @IdUsuario)
  AND (@IdPendencia = '' OR [pendenciahora].IdPendencia = @IdPendencia)
  AND ((@Data = '' AND FORMAT(GETDATE(), 'yyyy-MM-dd') = [pendenciahora].Data) OR (@Data = [pendenciahora].Data))
ORDER BY
  CAST([pendenciahora].[HoraInicio] AS TIME)  

/*************************************************************************************************************************
    
        SELECT [IdTipoHora], [DescricaoTipoHora], [Ativo] FROM Tipo_Horas WITH(NOLOCk)
        WHERE [IdTipoHora] IN (4,6,8,10,14,17,28,33) ORDER BY DescricaoTipoHora


                                                 [DELETAR HORA]
                        BEGIN TRAN DELETE FROM Pendencias_Horas WHERE IdPendenciaHoras = ''
                                
                                              [ATUALIZAR APONTAMENTO]
                                                  [Atualizar Hora]
        BEGIN TRAN UPDATE Pendencias_Horas SET HoraInicio = '1900-01-01 14:17:43.000' WHERE IdPendenciaHoras = ''
        BEGIN TRAN UPDATE Pendencias_Horas SET HoraFim = '1899-12-30 15:41:12.000' WHERE IdPendenciaHoras = ''
                                             [Atualizar Tipo Apontamento]
        BEGIN TRAN UPDATE Pendencias_Horas SET IdTipoHora = 6 WHERE IdPendenciaHoras = ''

                
                                              [ATUALIZAR PENDENCIA]
                                                [Trocar a Pasta]
        BEGIN TRAN UPDATE Pendencias SET IdNode = 1656 WHERE IdPendencia = ''



                                             COMMIT            ROLLBACK                                        
                                  
                                  
*************************************************************************************************************************/

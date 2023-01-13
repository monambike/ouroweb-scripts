SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @PendenciaId AS INT = 68424;

WITH
  Requisitos_CTE
  AS
  (
    SELECT
        [Requisito].[pk_int_Requisito] AS [RequisitoId]
      , [Requisito].[str_Nome]         AS [Assunto do Requisito]
    FROM
      [Requisito] AS [Requisito]
    WHERE
      [Requisito].[fk_int_Pendencia] = @PendenciaId
  ),
  InformacoesDaPendencia
  AS
  (
    SELECT
        [Pendencia].[IdPendencia] AS [PendenciaId]
      , [Pendencia].[Assunto]     AS [Assunto da Pendência]
      , [Aplicativo].[str_Nome]   AS [Nome do Aplicativo]
    FROM
      [Pendencias] AS [Pendencia]
      INNER JOIN
      [ClienteProdutoAplicativo] AS [ClienteProdutoAplicativo] ON [Pendencia].[fk_int_ProdutoAplicativo]                = [ClienteProdutoAplicativo].[pk_int_ClienteProdutoAplicativo]
      INNER JOIN
      [ProdutoAplicativo]        AS [ProdutoAplicativo]        ON [ClienteProdutoAplicativo].[fk_int_ProdutoAplicativo] = [ProdutoAplicativo].[pk_int_ProdutoAplicativo]
      INNER JOIN
      [Aplicativo]               AS [Aplicativo]               ON [ProdutoAplicativo].[fk_int_Aplicativo]               = [Aplicativo].[pk_int_Aplicativo]
    WHERE
      [Pendencia].[IdPendencia] = @PendenciaId
  )


/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e par�metros a serem
  utilizados nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.
  
  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por permiss�es.

**************************************************************************************/

DECLARE
  @SearchForPermissionID          AS INT          = '<Filtrar por: ID da Permiss�o, INT, >'
, @SearchForPermissionName        AS VARCHAR(MAX) = '<Filtrar por: Nome da Permiss�o, VARCHAR, >'
, @SearchForPermissionDescription AS VARCHAR(MAX) = '<Filtrar por: Descri��o da Permiss�o, VARCHAR, >'
    
, @SearchForPermissionType AS INT = '<Filtrar por: Tipo da Permiss�o, INT, >'


SELECT
  [IdRotina]        AS "ID"
, [NomeRotina]      AS "Nome"
, [DescricaoRotina] AS "Descri��o"
, [TipoRotina]      AS "Tipo"
FROM
  [Rotinas] AS [Permissao]
WHERE
      (@SearchForPermissionID          = '' OR [Permissao].[IdRotina]        = @SearchForPermissionID)
  AND (@SearchForPermissionName        = '' OR [Permissao].[NomeRotina]      LIKE ('%' + @SearchForPermissionName        + '%'))
  AND (@SearchForPermissionDescription = '' OR [Permissao].[DescricaoRotina] LIKE ('%' + @SearchForPermissionDescription + '%'))
  AND (@SearchForPermissionType        = '' OR [Permissao].[TipoRotina]      = @SearchForPermissionType)

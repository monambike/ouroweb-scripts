/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e par�metros a serem
  utilizados nesse template. Ap�s, pressione "[F5]" para usar o Script abaixo.
  
  ===================================================================================
   Pequena Descri��o do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por permiss�es.

**************************************************************************************/

DECLARE
    @SearchForPermissionID          AS INT = <Filtrar por: ID da Permiss�o, INT, >
  , @SearchForPermissionName        AS VARCHAR(MAX) = '<Filtrar por: Nome da Permiss�o, VARCHAR, >'
  , @SearchForPermissionDescription AS VARCHAR(MAX) = '<Filtrar por: Descri��o da Permiss�o, VARCHAR, >'
    
  , @SearchForPermissionType AS INT = <Filtrar por: Tipo da Permiss�o, INT, >


SELECT
    IdRotina        AS [ID]
  , NomeRotina      AS [Nome da Permiss�o]
  , DescricaoRotina AS [Descri��o da Permiss�o]
  , TipoRotina      AS [Tipo de Permiss�o]
FROM
  Rotinas AS a
WHERE
  (@SearchForPermissionID              = '' OR a.IdRotina        = @SearchForPermissionID)
  AND (@SearchForPermissionName        = '' OR a.NomeRotina      LIKE ('%' + @SearchForPermissionName + '%'))
  AND (@SearchForPermissionDescription = '' OR a.DescricaoRotina LIKE ('%' + @SearchForPermissionDescription + '%'))
  AND (@SearchForPermissionType        = '' OR a.TipoRotina      = @SearchForPermissionType)

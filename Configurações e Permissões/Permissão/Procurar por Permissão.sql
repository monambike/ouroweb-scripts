/**************************************************************************************

  Press CTRL + SHIFT + M to define parameters and values to be used on this
  current template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por permissões.

**************************************************************************************/

DECLARE
    @SearchForPermissionID          AS INT = <Filtrar por: ID da Permissão, INT, >
  , @SearchForPermissionName        AS VARCHAR(MAX) = '<Filtrar por: Nome da Permissão, VARCHAR, >'
  , @SearchForPermissionDescription AS VARCHAR(MAX) = '<Filtrar por: Descrição da Permissão, VARCHAR, >'
    
  , @SearchForPermissionType AS INT = <Filtrar por: Tipo da Permissão, INT, >


SELECT
    IdRotina        AS [ID]
  , NomeRotina      AS [Nome da Permissão]
  , DescricaoRotina AS [Descrição da Permissão]
  , TipoRotina      AS [Tipo de Permissão]
FROM
  Rotinas AS a
WHERE
  (@SearchForPermissionID              = '' OR a.IdRotina        = @SearchForPermissionID)
  AND (@SearchForPermissionName        = '' OR a.NomeRotina      LIKE ('%' + @SearchForPermissionName + '%'))
  AND (@SearchForPermissionDescription = '' OR a.DescricaoRotina LIKE ('%' + @SearchForPermissionDescription + '%'))
  AND (@SearchForPermissionType        = '' OR a.TipoRotina      = @SearchForPermissionType)

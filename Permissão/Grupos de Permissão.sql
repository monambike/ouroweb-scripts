/**************************************************************************************

  Press CTRL + SHIFT + M to define parameters and values to be used on this
  current template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por permiss�es e grupo de permiss�es.

**************************************************************************************/

DECLARE
  @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permiss�o, VARCHAR, >',
    
  @SearchForRoutineInGroup AS VARCHAR(MAX) = '<Filtrar por: Rotina no Grupo, VARCHAR, >',
  @SearchForUserInGroup AS VARCHAR(MAX) = '<Filtrar por: Usu�rio no Grupo, VARCHAR, >'


SELECT
  MainSelect.IdGrupo,
  MainSelect.[Nome da Permiss�o],
  MainSelect.[Rotinas Nesse Grupo],
  MainSelect.[Usu�rios Nesse Grupo]
FROM
(
  SELECT
    a.IdGrupo,
    a.DescricaoGrupo AS 'Nome da Permiss�o',
    'Rotinas Nesse Grupo' = dbo.GetRoutines(a.IdGrupo),
    'Usu�rios Nesse Grupo' = dbo.GetUsers(a.IdGrupo)
  FROM
    Grupos_Usuarios AS a
      INNER JOIN
    Rotinas_Direitos_Usuario AS b
        ON a.IdGrupo = b.IdGrupo
      INNER JOIN
    Usuarios_Grupos AS c
        ON a.IdGrupo = c.IdGrupo
  GROUP BY
    a.IdGrupo,
    a.DescricaoGrupo
) AS MainSelect
WHERE
  (@SearchForPermissionGroupName = '' OR MainSelect.[Nome da Permiss�o] LIKE ('%' + @SearchForPermissionGroupName + '%')) AND
  (@SearchForRoutineInGroup = '' OR MainSelect.[Rotinas Nesse Grupo] LIKE ('%| ' + @SearchForRoutineInGroup + ' |%')) AND
  (@SearchForUserInGroup = '' OR MainSelect.[Usu�rios Nesse Grupo] LIKE ('%| ' + @SearchForUserInGroup + ' |%'))
ORDER BY
  MainSelect.IdGrupo

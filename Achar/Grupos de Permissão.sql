-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 AP�S ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permiss�o, VARCHAR, >',
    
    @SearchForRoutineInGroup AS VARCHAR(MAX) = '<Filtrar por: Rotina no Grupo, VARCHAR, >',
    @SearchForUserInGroup AS VARCHAR(MAX) = '<Filtrar por: Usu�rio no Grupo, VARCHAR, >'
    --'Usu�rios' = 'teste' + (SELECT * FROM Rotinas_Direitos_Usuario WHERE a.)
END


BEGIN TRY
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
END TRY
BEGIN CATCH
    PRINT('Ocorreu um erro desconhecido, por favor, tente novamente')
END CATCH
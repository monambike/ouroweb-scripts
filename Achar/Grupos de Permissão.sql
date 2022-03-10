-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 APÓS ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permissão, VARCHAR, >',
    
    @SearchForRoutineInGroup AS VARCHAR(MAX) = '<Filtrar por: Rotina no Grupo, VARCHAR, >',
    @SearchForUserInGroup AS VARCHAR(MAX) = '<Filtrar por: Usuário no Grupo, VARCHAR, >'
    --'Usuários' = 'teste' + (SELECT * FROM Rotinas_Direitos_Usuario WHERE a.)
END


BEGIN TRY
  SELECT
    MainSelect.IdGrupo,
    MainSelect.[Nome da Permissão],
    MainSelect.[Rotinas Nesse Grupo],
    MainSelect.[Usuários Nesse Grupo]
  FROM
  (
    SELECT
      a.IdGrupo,
      a.DescricaoGrupo AS 'Nome da Permissão',
      'Rotinas Nesse Grupo' = dbo.GetRoutines(a.IdGrupo),
      'Usuários Nesse Grupo' = dbo.GetUsers(a.IdGrupo)
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
    (@SearchForPermissionGroupName = '' OR MainSelect.[Nome da Permissão] LIKE ('%' + @SearchForPermissionGroupName + '%')) AND
    (@SearchForRoutineInGroup = '' OR MainSelect.[Rotinas Nesse Grupo] LIKE ('%| ' + @SearchForRoutineInGroup + ' |%')) AND
    (@SearchForUserInGroup = '' OR MainSelect.[Usuários Nesse Grupo] LIKE ('%| ' + @SearchForUserInGroup + ' |%'))
  ORDER BY
    MainSelect.IdGrupo
END TRY
BEGIN CATCH
    PRINT('Ocorreu um erro desconhecido, por favor, tente novamente')
END CATCH
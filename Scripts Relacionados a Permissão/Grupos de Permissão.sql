/**************************************************************************************

  Press CTRL + SHIFT + M to define parameters and values to be used on this
  current template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por permiss�es e grupo de permiss�es.

**************************************************************************************/

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutines]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutines]
GO

CREATE FUNCTION GetRoutines (@IdGrupo AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Routines VARCHAR(MAX) = '| '

  SELECT @Routines += CAST(IdRotina AS VARCHAR(10)) + ' | '
  FROM Rotinas_Direitos_Usuario
  WHERE IdGrupo = @IdGrupo
  GROUP BY IdRotina

  RETURN @Routines
END
GO


IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetUsers]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetUsers]
GO

CREATE FUNCTION GetUsers (@IdGrupo AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Usuarios VARCHAR(MAX) = '| '

  SELECT @Usuarios += CAST(IdUsuario AS VARCHAR(10)) + ' | '
  FROM Usuarios_Grupos
  WHERE IdGrupo = @IdGrupo
  GROUP BY IdUsuario
  
  RETURN @Usuarios
END
GO

DECLARE
  @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permiss�o, VARCHAR, >',
  @SearchForRoutineInGroup AS VARCHAR(MAX) = '<Filtrar por: Rotina no Grupo, VARCHAR, >',
  @SearchForUserInGroup AS VARCHAR(MAX) = '<Filtrar por: Usu�rio no Grupo, VARCHAR, >'

SELECT
  [MainSelect].[IdGrupo]              AS [IdGrupo],
  [MainSelect].[Nome da Permiss�o]    AS [Nome da Permiss�o],
  [MainSelect].[Rotinas Nesse Grupo]  AS [Rotinas Nesse Grupo],
  [MainSelect].[Usu�rios Nesse Grupo] AS [Usu�rios Nesse Grupo]
FROM
(
  SELECT
    [a].[IdGrupo]                  AS [IdGrupo],
    [a].[DescricaoGrupo]           AS [Nome da Permiss�o],
    dbo.GetRoutines([a].[IdGrupo]) AS [Rotinas Nesse Grupo],
    dbo.GetUsers([a].[IdGrupo])    AS [Usu�rios Nesse Grupo]
  FROM
    Grupos_Usuarios AS [a]
      INNER JOIN
    Rotinas_Direitos_Usuario AS [b]
        ON [a].[IdGrupo] = [b].[IdGrupo]
      INNER JOIN
    Usuarios_Grupos AS [c]
        ON [a].[IdGrupo] = [c].[IdGrupo]
  GROUP BY
    [a].[IdGrupo],
    [a].[DescricaoGrupo]
) AS [MainSelect]
WHERE
  (@SearchForPermissionGroupName = '' OR [MainSelect].[Nome da Permiss�o] LIKE ('%' + @SearchForPermissionGroupName + '%'))
  AND (@SearchForRoutineInGroup = '' OR [MainSelect].[Rotinas Nesse Grupo] LIKE ('%| ' + @SearchForRoutineInGroup + ' |%'))
  AND (@SearchForUserInGroup = '' OR [MainSelect].[Usu�rios Nesse Grupo] LIKE ('%| ' + @SearchForUserInGroup + ' |%'))
ORDER BY
  [MainSelect].[IdGrupo]

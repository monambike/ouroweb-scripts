/**************************************************************************************

  Press CTRL + SHIFT + M to define parameters and values to be used on this
  current template.

  DESCRIPTION
  -------------------------------------------------------------------------------------
  Esse Script tem como objetivo facilitar a procura por permissões e grupo de permissões.

**************************************************************************************/

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutines]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutines]
GO
CREATE FUNCTION GetRoutines (@IdGrupo AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Routines VARCHAR(MAX) = '| '

  SELECT @Routines += CAST(IdRotina AS VARCHAR(10)) + ' | ' FROM [Rotinas_Direitos_Usuario] WHERE [IdGrupo] = @IdGrupo GROUP BY [IdRotina]
  IF @Routines = '| ' SET @Routines = ''

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

  SELECT @Usuarios += CAST(IdUsuario AS VARCHAR(10)) + ' | ' FROM [Usuarios_Grupos] WHERE [IdGrupo] = @IdGrupo GROUP BY [IdUsuario]
  IF @Usuarios = '| ' SET @Usuarios = ''

  RETURN @Usuarios
END
GO


DECLARE
    @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permissão, VARCHAR, >'
  , @SearchForRoutineInGroup      AS VARCHAR(MAX) = '<Filtrar por: Rotina no Grupo, VARCHAR, >'
  , @SearchForUserInGroup         AS VARCHAR(MAX) = '<Filtrar por: Usuário no Grupo, VARCHAR, >'

SELECT
    [main_select].[IdGrupo]              AS [IdGrupo]
  , [main_select].[Nome da Permissão]    AS [Nome da Permissão]
  , [main_select].[Rotinas Nesse Grupo]  AS [Rotinas Nesse Grupo]
  , [main_select].[Usuários Nesse Grupo] AS [Usuários Nesse Grupo]
FROM
(
  SELECT
      [grupo].[IdGrupo]                      AS [IdGrupo]
    , [grupo].[DescricaoGrupo]               AS [Nome da Permissão]
    , [dbo].[GetRoutines]([grupo].[IdGrupo]) AS [Rotinas Nesse Grupo]
    , [dbo].[GetUsers]([grupo].[IdGrupo])    AS [Usuários Nesse Grupo]
  FROM
    [Grupos_Usuarios]          AS [grupo] WITH(NOLOCK)
  GROUP BY [grupo].[IdGrupo], [grupo].[DescricaoGrupo]
) AS [main_select]
WHERE
  (@SearchForPermissionGroupName = '' OR [main_select].[Nome da Permissão]    LIKE ('%'   + @SearchForPermissionGroupName + '%'))
  AND (@SearchForRoutineInGroup  = '' OR [main_select].[Rotinas Nesse Grupo]  LIKE ('%| ' + @SearchForRoutineInGroup      + ' |%'))
  AND (@SearchForUserInGroup     = '' OR [main_select].[Usuários Nesse Grupo] LIKE ('%| ' + @SearchForUserInGroup         + ' |%'))
ORDER BY
  [main_select].[IdGrupo]
GO

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutines]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutines]
GO
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetUsers]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetUsers]
GO
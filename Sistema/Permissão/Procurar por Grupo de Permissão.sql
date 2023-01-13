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

  SELECT @Routines += CAST([IdRotina] AS VARCHAR(MAX)) + ' | ' FROM [Rotinas_Direitos_Usuario] WHERE [IdGrupo] = @IdGrupo GROUP BY [IdRotina]
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
  DECLARE @Users VARCHAR(MAX) = '| '

  SELECT @Users += CAST(IdUsuario AS VARCHAR(MAX)) + ' | ' FROM [Usuarios_Grupos] WHERE [IdGrupo] = @IdGrupo GROUP BY [IdUsuario]
  IF @Users = '| ' SET @Users = ''

  RETURN @Users
END
GO


DECLARE
    @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permissão, VARCHAR, >'
  , @SearchForPermissionInGroup      AS VARCHAR(MAX) = '<Filtrar por: Número da Permissão no Grupo, VARCHAR, >'
  , @SearchForUserInGroup         AS VARCHAR(MAX) = '<Filtrar por: Número do Usuário no Grupo, VARCHAR, >'

SELECT
    [main_select].[IdGrupo]            AS [IdGrupo]
  , [main_select].[NomeGrupoPermissao] AS [Nome do Grupo da Permissão (Nome da Rotina)]
  , [main_select].[PermissoesNoGrupo]  AS [Permissões Nesse Grupo]
  , [main_select].[UsuariosDoGrupo]    AS [Usuários Pertencentes à esse Grupo]
FROM
(
  SELECT
      [grupo].[IdGrupo]                      AS [IdGrupo]
    , [grupo].[DescricaoGrupo]               AS [NomeGrupoPermissao]
    , [dbo].[GetRoutines]([grupo].[IdGrupo]) AS [PermissoesNoGrupo]
    , [dbo].[GetUsers]([grupo].[IdGrupo])    AS [UsuariosDoGrupo]
  FROM
    [Grupos_Usuarios] AS [grupo] WITH(NOLOCK)
  GROUP BY [grupo].[IdGrupo], [grupo].[DescricaoGrupo]
) AS [main_select]
WHERE
      (@SearchForPermissionGroupName IN ('', CHAR(60) + 'Filtrar por: Nome do Grupo da Permissão, VARCHAR, '   + CHAR(62))
         OR [main_select].[NomeGrupoPermissao] LIKE ('%'   + @SearchForPermissionGroupName + '%'))
  AND (@SearchForPermissionInGroup   IN ('', CHAR(60) + 'Filtrar por: Número da Permissão no Grupo, VARCHAR, ' + CHAR(62))
         OR [main_select].[PermissoesNoGrupo]  LIKE ('%| ' + @SearchForPermissionInGroup      + ' |%'))
  AND (@SearchForUserInGroup         IN ('', CHAR(60) + 'Filtrar por: Número do Usuário no Grupo, VARCHAR, '   + CHAR(62))
         OR [main_select].[UsuariosDoGrupo]    LIKE ('%| ' + @SearchForUserInGroup         + ' |%'))
ORDER BY
  [main_select].[IdGrupo]
GO

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutines]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutines]
GO
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetUsers]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetUsers]
GO
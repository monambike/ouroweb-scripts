/**************************************************************************************

  Pressione "[CTRL] + [SHIFT] + [M]" para definir os valores e parâmetros a serem
  utilizados nesse template. Após, pressione "[F5]" para usar o Script abaixo.
  Ou pressione "[F5]" para retornar todos os registros.
  
  ===================================================================================
   Pequena Descrição do Script
  ===================================================================================

  Esse Script tem como objetivo facilitar a procura por permissões e grupo de
  permissões.

  ===================================================================================
   Comandos Auxiliares
  ===================================================================================

  Procurar por um usuário pelo seu ID:
  SELECT * FROM [Tab_Usuários] WHERE [IdUsuario] = @ID

**************************************************************************************/

/* Criação da procedure para retornar o nome das permissões vinculadas à um determinado grupo */
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutinesByGroupID]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutinesByGroupID]
GO
CREATE FUNCTION [dbo].[GetRoutinesByGroupID] (@GrupoID AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Routines VARCHAR(MAX) = '| '

  SELECT @Routines += CAST([IdRotina] AS VARCHAR(MAX)) + ' | ' FROM [Rotinas_Direitos_Usuario] WHERE [IdGrupo] = @GrupoID GROUP BY [IdRotina]
  IF @Routines = '| ' SET @Routines = ''

  RETURN @Routines
END
GO

/* Criação da procedure para retornar o nome dos usuários vinculados à um determinado grupo */
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetUsersByGroupID]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetUsersByGroupID]
GO
CREATE FUNCTION [dbo].[GetUsersByGroupID] (@GrupoID AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Users VARCHAR(MAX) = '| '
  
  SELECT @Users += CAST([IdUsuario] AS VARCHAR(MAX)) + ' | ' FROM [Usuarios_Grupos] WHERE [IdGrupo] = @GrupoID GROUP BY [IdUsuario]
  IF @Users = '| ' SET @Users = ''

  RETURN @Users
END
GO


DECLARE
  @SearchForPermissionGroupName AS VARCHAR(MAX) = '<Filtrar por: Nome do Grupo da Permissão, VARCHAR, >'
, @SearchForPermissionInGroup   AS VARCHAR(MAX) = '<Filtrar por: Número da Permissão no Grupo, VARCHAR, >'
, @SearchForUserInGroup         AS VARCHAR(MAX) = '<Filtrar por: Número do Usuário no Grupo, VARCHAR, >'

SELECT
  [main_select].[IdGrupo]            AS "ID (Grupo)"
, [main_select].[NomeGrupoPermissao] AS "Nome do Grupo"
, [main_select].[PermissoesNoGrupo]  AS "Permissões Nesse Grupo"
, [main_select].[UsuariosDoGrupo]    AS "Usuários Pertencentes à Esse Grupo"
FROM
(
  SELECT
    [grupo].[IdGrupo]                               AS "IdGrupo"
  , [grupo].[DescricaoGrupo]                        AS "NomeGrupoPermissao"
  , [dbo].[GetRoutinesByGroupID]([grupo].[IdGrupo]) AS "PermissoesNoGrupo"
  , [dbo].[GetUsersByGroupID]([grupo].[IdGrupo])    AS "UsuariosDoGrupo"
  FROM
    [Grupos_Usuarios] AS "grupo" WITH(NOLOCK)
  GROUP BY [grupo].[IdGrupo], [grupo].[DescricaoGrupo]
) AS [main_select]
WHERE
      (@SearchForPermissionGroupName IN ('', CHAR(60) + 'Filtrar por: Nome do Grupo da Permissão, VARCHAR, '   + CHAR(62))
         OR [main_select].[NomeGrupoPermissao] LIKE ('%'   + @SearchForPermissionGroupName + '%'))
  AND (@SearchForPermissionInGroup   IN ('', CHAR(60) + 'Filtrar por: Número da Permissão no Grupo, VARCHAR, ' + CHAR(62))
         OR [main_select].[PermissoesNoGrupo]  LIKE ('%| ' + @SearchForPermissionInGroup   + ' |%'))
  AND (@SearchForUserInGroup         IN ('', CHAR(60) + 'Filtrar por: Número do Usuário no Grupo, VARCHAR, '   + CHAR(62))
         OR [main_select].[UsuariosDoGrupo]    LIKE ('%| ' + @SearchForUserInGroup         + ' |%'))
ORDER BY
  [main_select].[IdGrupo]
GO

IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetRoutinesByGroupID]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetRoutinesByGroupID]
GO
IF EXISTS (SELECT * FROM   sys.objects WHERE  object_id = OBJECT_ID(N'[dbo].[GetUsersByGroupID]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].[GetUsersByGroupID]
GO

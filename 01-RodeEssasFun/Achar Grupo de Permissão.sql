--DROP FUNCTION GetRoutines 
--DROP FUNCTION GetUsers
--GO


CREATE FUNCTION GetRoutines (@IdGrupo AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Routines VARCHAR(MAX) = ''

  SELECT
    @Routines += CAST(IdRotina AS VARCHAR(10)) + ' | '
  FROM
    Rotinas_Direitos_Usuario
  WHERE
    IdGrupo = @IdGrupo
  GROUP BY IdRotina

  RETURN '| ' + @Routines
END
GO


CREATE FUNCTION GetUsers (@IdGrupo AS INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
  DECLARE @Usuarios VARCHAR(MAX) = ''

  SELECT
    @Usuarios += CAST(IdUsuario AS VARCHAR(10)) + ' | '
  FROM
    Usuarios_Grupos
  WHERE
    IdGrupo = @IdGrupo
  GROUP BY IdUsuario
  
  RETURN '| ' + @Usuarios
END
GO
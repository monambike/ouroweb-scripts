-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 AP�S ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForPermissionID AS INT = <Filtrar por: ID da Permiss�o, INT, 0>,
    @SearchForPermissionName AS VARCHAR(MAX) = '<Filtrar por: Nome da Permiss�o, VARCHAR, >',
    @SearchForPermissionDescription AS VARCHAR(MAX) = '<Filtrar por: Descri��o da Permiss�o, VARCHAR, >',

    @SearchForPermissionType AS INT = <Filtrar por: Tipo da Permiss�o, INT, 0>
END


BEGIN TRY
  SELECT
    IdRotina AS 'ID',
    NomeRotina AS 'Nome da Permiss�o',
    DescricaoRotina AS 'Descri��o da Permiss�o',
    TipoRotina AS 'Tipo de Permiss�o'
  FROM
    Rotinas AS a
  WHERE
    (@SearchForPermissionID = 0 OR a.IdRotina = @SearchForPermissionID) AND
    (@SearchForPermissionName = '' OR a.NomeRotina LIKE ('%' + @SearchForPermissionName + '%')) AND
    (@SearchForPermissionDescription = '' OR a.DescricaoRotina LIKE ('%' + @SearchForPermissionDescription + '%')) AND
    (@SearchForPermissionType = 0 OR a.TipoRotina = @SearchForPermissionType)
END TRY
BEGIN CATCH
    PRINT('Ocorreu um erro desconhecido, por favor, tente novamente')
END CATCH
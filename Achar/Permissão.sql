-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 APÓS ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @SearchForPermissionID AS INT = <Filtrar por: ID da Permissão, INT, 0>,
    @SearchForPermissionName AS VARCHAR(MAX) = '<Filtrar por: Nome da Permissão, VARCHAR, >',
    @SearchForPermissionDescription AS VARCHAR(MAX) = '<Filtrar por: Descrição da Permissão, VARCHAR, >',

    @SearchForPermissionType AS INT = <Filtrar por: Tipo da Permissão, INT, 0>
END


BEGIN TRY
  SELECT
    IdRotina AS 'ID',
    NomeRotina AS 'Nome da Permissão',
    DescricaoRotina AS 'Descrição da Permissão',
    TipoRotina AS 'Tipo de Permissão'
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
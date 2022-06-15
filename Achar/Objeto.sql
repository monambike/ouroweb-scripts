-- PRESSIONE [CTRL + SHIFT + M] PARA ESCOLHER OS FILTROS
-- PRESSIONE F5 APÓS ESCOLHER OS FILTROS PARA FILTRAR
BEGIN -- Filters
  DECLARE
    @MatchAccents AS BIT = <Considerar: Acentuação, BIT, 0>,

    @SearchForObjectName AS VARCHAR(MAX) = '<Filtrar por: Nome do Objeto, VARCHAR, >',
    @SearchForParameterName AS VARCHAR(MAX) = '<Filtrar por: Nome do Parâmetro, VARCHAR, >',

    /* [SUGESTÃO]
    Fazer com que seja possível filtrar pela:
     - Data de criação,
     - Data de modificação.
    */

    -- Filtros de Switch
    @ShowProcedures AS BIT = <Mostrar Apenas: Procedures, BIT, 0>,
    @ShowExtendedProcedures AS BIT = <Mostrar Apenas: Procedures Extendidas, BIT, 0>,
    @ShowFunctions AS BIT = <Mostrar Apenas: Funções, BIT, 0>,
    @ShowViews AS BIT = <Mostrar Apenas: Views, BIT, 0>,
    @ShowTables AS BIT = <Mostrar Apenas: Tabelas, BIT, 0>

    /* [SUGESTÃO]
    Fazer com que seja possível ordenar por:
      - Nome do Objeto,
      - Parâmetro do Objeto,
      - Tipo do Objeto,
      - Data de Criação,
      - Data de Modificação.
    */
END


BEGIN -- Validations
  -- Criação da tabela temporária que conterá o conteúdo dos filtros de switch que serão realizados
  IF EXISTS (SELECT * FROM TEMPDB.SYS.TABLES WHERE NAME LIKE ('#Temp_SelectedObjectTypes%'))
  BEGIN
    EXEC ('DROP TABLE #Temp_SelectedObjectTypes')
  END
  CREATE TABLE #Temp_SelectedObjectTypes(
    ObjectType
      NVARCHAR(2)
      COLLATE Latin1_General_CI_AS_KS_WS
  )

  -- Validação de filtros de switch
  IF (@ShowProcedures = 0 AND
      @ShowExtendedProcedures  = 0 AND
      @ShowFunctions  = 0 AND
      @ShowViews = 0 AND
      @ShowTables  = 0)
    INSERT #Temp_SelectedObjectTypes VALUES ('P'), ('X'), ('FN'), ('AF'), ('IF'), ('TF'), ('V'), ('U')
  IF @ShowProcedures = 1
    INSERT #Temp_SelectedObjectTypes VALUES ('P')
  IF @ShowExtendedProcedures = 1
    INSERT #Temp_SelectedObjectTypes VALUES ('X')
  IF @ShowFunctions = 1
    INSERT #Temp_SelectedObjectTypes VALUES ('FN'), ('AF'), ('IF'), ('TF')
  IF @ShowViews = 1
    INSERT #Temp_SelectedObjectTypes VALUES ('V')
  IF @ShowTables = 1
    INSERT #Temp_SelectedObjectTypes VALUES ('U')
END

BEGIN -- Result
    BEGIN
      SELECT
        a.OBJECT_ID AS 'ID do Objeto',
        a.NAME 'Nome do Objeto',
        b.NAME AS 'Parâmetro do Objeto (Se Possui)',
        a.TYPE AS 'Tipo do Objeto',
        a.TYPE_DESC 'Descrição do Tipo do Objeto',
        a.CREATE_DATE AS 'Data de Criação',
        a.MODIFY_DATE AS 'Data de Modificação'
      FROM
        SYS.ALL_OBJECTS AS a
          FULL JOIN
        SYS.PARAMETERS AS b
            ON a.OBJECT_ID = b.OBJECT_ID
      WHERE
        (
          (@MatchAccents = 0) AND
            (@SearchForObjectName = '' OR a.NAME COLLATE Latin1_general_CI_AI LIKE ('%' + @SearchForObjectName + '%') COLLATE Latin1_general_CI_AI)
          OR
          (@MatchAccents = 1) AND
            (@SearchForObjectName = '' OR a.NAME LIKE ('%' + @SearchForObjectName + '%'))
        )
        AND
        (a.TYPE IN (SELECT ObjectType FROM #Temp_SelectedObjectTypes)) AND
        (@SearchForObjectName = '' OR a.NAME LIKE ('%' + @SearchForObjectName + '%')) AND
        (@SearchForParameterName = '' OR b.NAME LIKE ('%' + @SearchForParameterName + '%'))
    END
END
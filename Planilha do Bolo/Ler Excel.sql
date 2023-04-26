/*
sp_configure 'show advanced options', 1
reconfigure
go
sp_configure 'Ad Hoc Distributed Queries', 1
reconfigure
go
sp_configure 'show advanced options', 0
reconfigure
*/

DECLARE @PlanilhaDoBolo2023Path AS VARCHAR(MAX) = '' 

SELECT *
FROM OPENROWSET(
  'Microsoft.ACE.OLEDB.12.0'
, 'Excel 12.0;Database=C:\TMP\Vinicius\BackupMapaMedicamentos\planilhabolo2023.xlsx;HDR=YES'
, 'SELECT * FROM [sheet1$]'
)
SELECT *
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
    'Data Source=C:\TMP\Vinicius\BackupMapaMedicamentos\planilhabolo2023.xlsx;Extended Properties=Excel 12.0')...[Sheet1$];
GO

DROP TABLE #Teste
CREATE TABLE #Teste (Teste VARCHAR(MAX))

BULK INSERT #Teste FROM 'C:\TMP\Vinicius\BackupMapaMedicamentos\planilhabolo2023.xlsx'
   WITH (
      FIELDTERMINATOR = ',',
      ROWTERMINATOR = '\n'
);
GO
SELECT * FROM #Teste

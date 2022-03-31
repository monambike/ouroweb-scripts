SELECT  
  [a].[restore_date]
  ,[a].[destination_database_name]
  ,[a].[user_name]
  ,[a].[backup_set_id]
  ,[a].[restore_type]
  ,[a].[replace]
  ,[a].[recovery]
  ,[a].[restart]
FROM
  [msdb].[dbo].[restorehistory] AS [a] WITH(NOLOCk)
ORDER BY
  [a].restore_date

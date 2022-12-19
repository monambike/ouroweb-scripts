Set Nocount On
Declare 
		@str_databasename varchar(500) = 'MilFarmaVs994_DVP', --DatabaseName
		@str_databaselogname nvarchar(500),
		@int_databasestart int,
		@int_databaseend int,
		@str_commandsql nvarchar(4000)

Declare @tmp_databases Table(int_counter int identity(1,1),databasename varchar(500), databaselogname varchar(500))

Insert Into 
	@tmp_databases
Select 
	'databasename' = a.name, 
	'databaselogname' = b.name 
From 
	sys.databases a
		inner join
	sys.master_files b
			on a.database_id = b.database_id 
Where 
	a.name = @str_databasename and
	a.name not in('master','model','msdb', 'tempdb') and
	b.file_id  = 2
Order by 
	a.Name

Select 
	@int_databasestart = Min(int_counter),
	@int_databaseend = Max(int_counter) 
From 
	@tmp_databases


While @int_databasestart <= @int_databaseend
Begin	
	Select 
		@str_databasename = databasename,		
		@str_databaselogname = databaselogname
	From 
		@tmp_databases 
	Where 
		int_counter = @int_databasestart
	
	Print @str_databasename

	Set @str_commandsql = ''
	Set @str_commandsql = @str_commandsql + 'Use [' + @str_databasename + '];' + char(13)
	Set @str_commandsql = @str_commandsql + 'Alter Database [' + @str_databasename + ']' + Char(13)
	Set @str_commandsql = @str_commandsql + 'Set Recovery Simple;' + Char(13)
	Set @str_commandsql = @str_commandsql + 'DBCC ShrinkFile('+ ''''+ @str_databaselogname + '''' + ');' + Char(13)
	Set @str_commandsql = @str_commandsql + 'Alter Database [' + @str_databasename + ']' + Char(13)
	Set @str_commandsql = @str_commandsql + 'Set Recovery Full;' + Char(13) + Char(13)
	
	Execute (@str_commandsql)
	Set @int_databasestart = @int_databasestart + 1

End
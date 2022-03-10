select	
	'Field'			= a.name,
	'Type'			= c.name,
	'Size'			= (case c.name
										when 'char' then convert(varchar, a.max_length)
										when 'nchar' then convert(varchar, a.max_length / 2)
										when 'ntext' then convert(varchar, a.max_length)
										when 'nvarchar' then convert(varchar, a.max_length / 2)
										when 'text' then convert(varchar, a.max_length)
										when 'varchar' then convert(varchar, a.max_length)
										else ''
								end),
	'Nullable'	= a.is_nullable	,
	'NomeTabela' = b.name
from
	sys.columns as a with(nolock)
		inner join
	sys.tables as b with(nolock)
			on a.object_id = b.object_id
		inner join
	sys.types as c with(nolock)
			on a.user_type_id = c.user_type_id
where
	a.name like '%ser%' and
	b.name = 'Tab_TiposMovimentos'
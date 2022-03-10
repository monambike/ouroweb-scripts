 select
	'Cached Size (MB)'		= count(*) * 8 / 1024, 
	'Database'						= case database_id
														when 32767
															then 'ObjectDb'
														else db_name(database_id)
													end
from
	sys.dm_os_buffer_descriptors
group by
	db_name(database_id),
	database_id
order by
	'Cached Size (MB)' desc

DBCC FREEPROCCACHE
GO
DBCC DROPCLEANBUFFERS
GO
DBCC FREESYSTEMCACHE ('ALL')
GO
DBCC FREESESSIONCACHE 

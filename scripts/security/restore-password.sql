EXEC sp_configure updates,1
GO

reconfigure with override
GO

UPDATE master.sys.syslogins 
SET password=O.password
FROM old_login O, sys.syslogins L 
WHERE L.name=O.name
AND O.name='sa'
GO
EXEC sp_configure updates,0
GO

reconfigure with override
GO

DROP TABLE old_login
go
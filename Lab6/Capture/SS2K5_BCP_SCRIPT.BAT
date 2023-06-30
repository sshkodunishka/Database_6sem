rem  %1 DBA login id
rem  %2 password
rem  %3 database name 
rem  %4 database server name
rem  %5 end or column delimiter
rem  %6 end of row delimiter

echo OfflinePluginIdentifier=oracle.dbtools.migration.workbench.plugin.SQLServer2005Plugin>sqlserver2005.ocp
rem store the delimiters
bcp "select '%5' " queryout COLUMN.TXT -c -e COLUMN.ERR -t "" -r "" -U%1 -P%2 -S%4
bcp "select '%6' " queryout ROW.TXT -c -e ROW.ERR -t "" -r "" -U%1 -P%2 -S%4


rem export the required system tables in the master database
bcp "select CAST(name AS VARCHAR(128)), '%5', database_id, '%5', '%6' from master.sys.databases" queryout master\SS2K5_DATABASES.dat -c -e master\SS2K5_DATABASES.ERR -U%1 -P%2 -S%4

rem export the required system tables in the database to be migrated
bcp "select CAST(SCHEMA_OWNER as VARCHAR(128)), '%5', CAST(SCHEMA_NAME as VARCHAR(128)), '%5', '%6' from  %3.INFORMATION_SCHEMA.SCHEMATA" queryout %3\SS2K5_SCHEMATA.dat -c -e %3\SS2K5_SCHEMATA.ERR -U%1 -P%2 -S%4
bcp "select GRANTOR, '%5', TABLE_SCHEMA, '%5', TABLE_NAME, '%5', PRIVILEGE_TYPE, '%5', IS_GRANTABLE, '%5', GRANTEE, '%5', '%6' from  %3.INFORMATION_SCHEMA.TABLE_PRIVILEGES" queryout %3\SS2K5_TABLE_PRIVILEGES.dat -c -e %3\SS2K5_TABLE_PRIVILEGES.ERR -U%1 -P%2 -S%4
bcp "select object_id, '%5', parent_column_id, '%5', definition, '%5', '%6' from  %3.sys.check_constraints" queryout %3\SS2K5_CHECK_CONSTRAINTS.dat -c -e %3\SS2K5_CHECK_CONSTRAINTS.ERR -U%1 -P%2 -S%4
bcp "select name, '%5',rule_object_id, '%5',column_id, '%5',max_length, '%5',precision, '%5',scale, '%5',is_nullable, '%5',user_type_id, '%5',system_type_id, '%5',default_object_id, '%5',object_id, '%5', '%6' from  %3.sys.columns" queryout %3\SS2K5_COLUMNS.dat -c -e %3\SS2K5_COLUMNS.ERR -U%1 -P%2 -S%4
bcp "select default_schema_name, '%5',type, '%5',principal_id, '%5',owning_principal_id, '%5',name, '%5', sid, '%5', '%6' from  %3.sys.database_principals" queryout %3\SS2K5_DATABASE_PRINCIPALS.dat -c -e %3\SS2K5_DATABASE_PRINCIPALS.ERR -U%1 -P%2 -S%4
bcp "select member_principal_id, '%5', role_principal_id, '%5', '%6' from  %3.sys.database_role_members" queryout %3\SS2K5_DATABASE_ROLE_MEMBERS.dat -c -e %3\SS2K5_DATABASE_ROLE_MEMBERS.ERR -U%1 -P%2 -S%4
bcp "select constraint_column_id, '%5', constraint_object_id, '%5', parent_object_id, '%5', parent_column_id, '%5', referenced_column_id, '%5', referenced_object_id, '%5', '%6' from  %3.sys.foreign_key_columns" queryout %3\SS2K5_FOREIGN_KEY_COLUMNS.dat -c -e %3\SS2K5_FOREIGN_KEY_COLUMNS.ERR -U%1 -P%2 -S%4
bcp "select name , '%5', object_id, '%5', '%6' from  %3.sys.foreign_keys" queryout %3\SS2K5_FOREIGN_KEYS.dat -c -e %3\SS2K5_FOREIGN_KEYS.ERR -U%1 -P%2 -S%4
bcp "select seed_value, '%5', increment_value, '%5', last_value, '%5', object_id , '%5', column_id, '%5', '%6' from  %3.sys.identity_columns" queryout %3\SS2K5_IDENTITY_COLUMNS.dat -c -e %3\SS2K5_IDENTITY_COLUMNS.ERR -U%1 -P%2 -S%4
bcp "select index_column_id, '%5', object_id, '%5', index_id, '%5', column_id, '%5', '%6' from  %3.sys.index_columns" queryout %3\SS2K5_INDEX_COLUMNS.dat -c -e %3\SS2K5_INDEX_COLUMNS.ERR -U%1 -P%2 -S%4
bcp "select object_id, '%5', index_id, '%5', name, '%5', is_unique, '%5', is_primary_key, '%5', '%6' from  %3.sys.indexes" queryout %3\SS2K5_INDEXES.dat -c -e %3\SS2K5_INDEXES.ERR -U%1 -P%2 -S%4
bcp "select  schema_id, '%5',object_id, '%5',name, '%5', type, '%5',parent_object_id, '%5',is_ms_shipped, '%5', '%6' from  %3.sys.objects" queryout %3\SS2K5_OBJECTS.dat -c -e %3\SS2K5_OBJECTS.ERR -U%1 -P%2 -S%4
bcp "select  schema_id,'%5', name,'%5', '%6' from  %3.sys.schemas" queryout %3\SS2K5_SCHEMAS.dat -c -e %3\SS2K5_SCHEMAS.ERR -U%1 -P%2 -S%4
bcp "select name,'%5',sid,'%5',type,'%5', '%6' from  %3.sys.server_principals" queryout %3\SS2K5_SERVER_PRINCIPALS.dat -c -e %3\SS2K5_SERVER_PRINCIPALS.ERR -U%1 -P%2 -S%4
bcp "select CASE when (definition IS NULL) then '/* ddl not accessible */' else definition end,'%5',object_id,'%5', '%6' from  %3.sys.sql_modules" queryout %3\SS2K5_SQL_MODULES.dat -c -e %3\SS2K5_SQL_MODULES.ERR -U%1 -P%2 -S%4
bcp "select definition,'%5',object_id,'%5', '%6' from  %3.sys.DEFAULT_CONSTRAINTS" queryout %3\SS2K5_DEFAULT_CONSTRAINTS.dat -c -e %3\SS2K5_DEFAULT_CONSTRAINTS.ERR -U%1 -P%2 -S%4
bcp "select name, '%5', object_id, '%5',schema_id, '%5',type, '%5', '%6' from  %3.sys.tables" queryout %3\SS2K5_TABLES.dat -c -e %3\SS2K5_TABLES.ERR -U%1 -P%2 -S%4
bcp "select  name, '%5',user_type_id, '%5',system_type_id, '%5', '%6' from  %3.sys.types" queryout %3\SS2K5_TYPES.dat -c -e %3\SS2K5_TYPES.ERR -U%1 -P%2 -S%4
bcp "select  major_id, '%5',minor_id, '%5',name, '%5',value, '%5', '%6' from  %3.sys.extended_properties" queryout %3\SS2K5_SYSPROPERTIES.dat -c -e %3\SS2K5_SYSPROPERTIES.ERR -U%1 -P%2 -S%4

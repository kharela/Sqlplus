/**********************************************************
-- qdb
-- Displays information about current database

-- parameters:
-- No parameters

-- usage:
-- qdb
**********************************************************/

set lines 999 long 10000 term on head on ver off pages 50
col curr_pdb form a12
col platform_name form a30

select
   name,
   open_mode,
   log_mode,
   case when (select count(*) from v$pdbs)>1 then 'ROOT' else (select name from v$pdbs) end as CURR_PDB,
   flashback_on,
   platform_name,
   (select version from v$instance) as version
 from v$database;


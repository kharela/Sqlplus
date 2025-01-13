/**********************************************************

-- qsql_active
-- Display list of sql statements executing 

-- parameters:
-- 1 -  regexp pattern for username

-- usage:
-- qsql_active "user1|kh[a,u]..la|^c##"
**********************************************************/


--set defaults for parametersms
col fltr_username new_value v_username noprint
set echo off ver off head off feed off
select case when '&&1' is null then '.*' else '&1' end as fltr_username from dual;

--custom settings
set lines 999 long 10000 term on head on ver on feed on pages 50
col username for a12
col sql_text for a100 

--querys
select username, sid, serial#, p.sql_id, s.sql_text
   from v$session p, v$sql s
   where regexp_like(username, '&v_username', 'i')
     and p.sql_id = s.sql_id
	 and p.status='ACTIVE';

--exit settings
undef 1
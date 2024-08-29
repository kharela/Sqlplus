-- qsql_active

-- parameters:
-- 1 -  regexp pattern for username

-- usage:
-- qsql_active "user1|kh[a,u]..la|^c##"


--set defaults for parametersms
col fltr_username new_value v_username
select case when '&1' is null then '.*' else '&1' end as fltr_username from dual;

--custom settings
set lines 999
col username for a12
col sql_text for a100 

--query
select username, sid, serial#, p.sql_id, s.sql_text
   from v$session p, v$sql s
   where regexp_like(username, '&v_username', 'i')
     and p.sql_id = s.sql_id;


--exit settings

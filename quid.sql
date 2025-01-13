/**********************************************************
-- qid
-- Displays information about user IDs in the database

-- parameters:
-- ID pattern

-- usage:
-- qdid "user1|kh[a,u]..la|^c##"
**********************************************************/
--set defaults for parametersms
col fltr_username new_value v_username noprint
set echo off ver off head off feed off
select case when '&&1' is null then '.*' else '&1' end as fltr_username from dual;

--custom settings
set lines 999 long 10000 term on head on ver on feed on
col username for a12
col profile form a15

select username, authentication_type, profile, account_status,
    to_char(lock_date,'YYYY-MM-DD HH24:MI') lock_date,
	to_char(expiry_date, 'YYYY-MM-DD HH24:MI') expiry_date,
	to_char(last_login, 'YYYY-MM-DD HH24:MI') last_login
  -- password_change_date -- this column provided starting with 19c.
  from dba_users
  where regexp_like(username, '&v_username', 'i')
  order by 1;

--exit settings
undef 1


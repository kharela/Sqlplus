/**********************************************************
-- qid
-- Displays information about user owned tables
--    in the database

-- parameters:
-- ID pattern
-- Table name pattern

-- usage:
-- qdtab "user1|kh[a,u]..la|^c##" "tab1|tab2"
**********************************************************/
--set defaults for parametersms
col fltr_owner new_value v_owner noprint
col fltr_tab    new_value v_tablename noprint

set echo off ver off head off feed off
select case when '&&1' is null then '.*' else '&1' end as fltr_owner from dual;
select case when '&&2' is null then '.*' else '&2' end as fltr_tab from dual;

--custom settings
set lines 999 long 10000 term on head on ver on feed on pages 50
set echo off

col owner for a12
col table_name for a30
col tablespace_name for a30
col part for a4

--print &v_owner
--print &v_tablename

select
    owner,
    table_name,
    tablespace_name,
    num_rows,
    blocks,
    Partitioned 
    from all_tables t
      where regexp_like(owner, '&v_owner', 'i')
        and regexp_like(table_name, '&v_tablename', 'i');
\pset format html
-- SQL statements by total_plan_time
DO $$
DECLARE
    version_num int;
BEGIN
    SELECT current_setting('server_version_num')::int INTO version_num;

    IF version_num >= 130000 THEN
        EXECUTE '
SELECT auth.rolname AS "user", 
  db.datname AS "database", 
  ss.queryid,
  ss.calls,
  ss.total_plan_time,
  ss.plans,
          substring(replace(replace(replace(ss.query,E''\n'',''''),E''\r'',''''),E''\t'','''') FROM 1 FOR 64) AS "query substring 64"
FROM pg_stat_statements ss
JOIN pg_roles auth ON auth.oid = ss.userid
JOIN pg_database db ON db.oid = ss.dbid
WHERE ss.total_plan_time > 1 -- 1 ms
ORDER BY ss.total_plan_time DESC
limit 50;
        ';
    ELSE
        EXECUTE '
        SELECT ''Unavailable in Postgres 12'' AS message;
        ';
    END IF;
END $$;

-- Full output
DO $$
DECLARE
    version_num int;
BEGIN
    SELECT current_setting('server_version_num')::int INTO version_num;

    IF version_num >= 130000 THEN
        EXECUTE '
SELECT *
        FROM pg_stat_statements 
        WHERE total_plan_time > 1 -- 1 ms
        ORDER BY total_plan_time DESC
limit 50;
        ';
    ELSE
        EXECUTE '
        SELECT ''Unavailable in Postgres 12'' AS message;
        ';
    END IF;
END $$;
\pset format aligned

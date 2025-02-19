\pset format html
--SQL statements returning the most rows
SELECT auth.rolname AS "user", 
  db.datname AS "database", 
  ss.queryid,
  ss.calls,
  ss.rows,
  ss.rows / ss.calls AS "Rows per Call",
  substring(replace(replace(replace(ss.query,E'\n',''),E'\r',''),E'\t','') FROM 1 FOR 64) AS "query substring 64"
FROM pg_stat_statements ss
JOIN pg_roles auth ON auth.oid = ss.userid
JOIN pg_database db ON db.oid = ss.dbid
ORDER BY "Rows per Call" DESC
limit 50;

--Full output
SELECT ss.rows / ss.calls AS "Rows per Call",
*
FROM  pg_stat_statements ss
ORDER BY "Rows per Call" DESC
limit 50;
\pset format aligned
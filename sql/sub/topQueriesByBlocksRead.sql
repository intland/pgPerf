\pset format html
SELECT auth.rolname AS "user", 
  db.datname AS "database", 
  ss.queryid,
  ss.shared_blks_read,
  ss.local_blks_read,
  ss.shared_blks_hit,
  ss.calls,
  ss.shared_blks_read / ss.calls AS "Reads per Call",
  ss.rows / ss.calls AS "Rows per Call",
  substring(replace(replace(replace(ss.query,E'\n',''),E'\r',''),E'\t','') FROM 1 FOR 64) AS "query substring 64"
FROM pg_stat_statements ss
JOIN pg_roles auth ON auth.oid = ss.userid
JOIN pg_database db ON db.oid = ss.dbid
WHERE ss.shared_blks_read > 1000
ORDER BY ss.shared_blks_read DESC
limit 50;

--Full output
SELECT *
FROM  pg_stat_statements ss
WHERE ss.shared_blks_read > 1000
ORDER BY ss.shared_blks_read DESC
limit 50;
\pset format aligned

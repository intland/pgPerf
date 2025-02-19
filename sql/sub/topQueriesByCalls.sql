\pset format html
--SQL statements called most frequently
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
WHERE ss.calls > 1000
ORDER BY ss.calls DESC
limit 50;

--Full output
SELECT *
FROM  pg_stat_statements ss
WHERE ss.calls > 1000
ORDER BY ss.calls DESC
limit 50;
\pset format aligned
--- 16-11-2026 22:24:55 biblioteca.db.26
SELECT name, sql
FROM sqlite_master
WHERE type = 'table'
AND name NOT LIKE 'sqlite_%';



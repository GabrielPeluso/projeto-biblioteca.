--- 16-11-2026 21:10:40 biblioteca.db.17
SELECT sql
FROM sqlite_master
WHERE type = 'table'
  AND name NOT LIKE 'sqlite_%';



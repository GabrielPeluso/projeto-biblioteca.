--- 16-11-2026 18:58:14 biblioteca.db.3
SELECT name
FROM sqlite_master
WHERE type = 'table'
AND name NOT LIKE 'sqlite_%'
ORDER BY name;



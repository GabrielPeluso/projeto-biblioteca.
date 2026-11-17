--- 16-11-2026 18:50:28 biblioteca.db.1
PRAGMA foreign_keys = ON;


--- 16-11-2026 18:51:40 biblioteca.db.2
CREATE TABLE editora (
id_editora INTEGER PRIMARY KEY,
nome TEXT NOT NULL UNIQUE,
cidade TEXT
);



--- 16-11-2026 19:57:12 biblioteca.db.7
/***** ERROR ******
CREATE TABLE LIVRO (
    id_livro INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    autor TEXT NOT NULL,
    editora TEXT,
    ano_publicacao INTEGER,
    isbn TEXT UNIQUE,
    quantidade INTEGER DEFAULT 0 CHECK (quantidade >= 0),
    categoria TEXT,
    CHECK (ano_publicacao IS NULL OR ano_publicacao > 0)
);
 ----- 
SQLITE_ERROR: sqlite3 result code 1: table LIVRO already exists
*****/



--- 16-11-2026 20:16:33 biblioteca.db.11
CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    cargo TEXT NOT NULL,
    email TEXT UNIQUE
);



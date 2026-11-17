--- 16-11-2026 19:39:18 biblioteca.db.5
CREATE TABLE USUARIO (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    telefone TEXT,
    endereco TEXT,
    data_cadastro TEXT DEFAULT CURRENT_DATE
);



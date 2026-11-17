--- 16-11-2026 20:04:36 biblioteca.db.8
CREATE TABLE EMPRESTIMO (
    id_emprestimo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    data_emprestimo TEXT NOT NULL,
    data_devolucao_prevista TEXT NOT NULL,
    data_devolucao TEXT,

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario),

    FOREIGN KEY (id_funcionario)
        REFERENCES FUNCIONARIO(id_funcionario),

    CHECK (data_devolucao IS NULL OR
           data_devolucao >= data_emprestimo),

    CHECK (data_devolucao_prevista >= data_emprestimo)
);



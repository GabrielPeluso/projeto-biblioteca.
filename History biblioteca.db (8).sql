--- 16-11-2026 20:07:19 biblioteca.db.9
CREATE TABLE ITEM_EMPRESTIMO (
    id_item INTEGER PRIMARY KEY AUTOINCREMENT,
    id_emprestimo INTEGER NOT NULL,
    id_livro INTEGER NOT NULL,
    quantidade INTEGER DEFAULT 1 CHECK (quantidade > 0),

    FOREIGN KEY (id_emprestimo)
        REFERENCES EMPRESTIMO(id_emprestimo),

    FOREIGN KEY (id_livro)
        REFERENCES LIVRO(id_livro),

    UNIQUE (id_emprestimo, id_livro)
);



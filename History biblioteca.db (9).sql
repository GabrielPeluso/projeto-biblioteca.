--- 16-11-2026 20:08:25 biblioteca.db.10
CREATE TABLE RESERVA (
    id_reserva INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER NOT NULL,
    id_livro INTEGER NOT NULL,
    data_reserva TEXT DEFAULT CURRENT_DATE,
    status TEXT DEFAULT 'Pendente'
        CHECK (status IN ('Pendente', 'Confirmada', 'Cancelada')),

    FOREIGN KEY (id_usuario)
        REFERENCES USUARIO(id_usuario),

    FOREIGN KEY (id_livro)
        REFERENCES LIVRO(id_livro)
);



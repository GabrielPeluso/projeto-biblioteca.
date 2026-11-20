PRAGMA foreign_keys = ON;
BEGIN;
CREATE TABLE biblioteca (
 id_biblioteca INTEGER PRIMARY KEY, nome TEXT NOT NULL UNIQUE,
 endereco TEXT NOT NULL, telefone TEXT, email TEXT, horario TEXT,
 limite_emprestimos INTEGER NOT NULL DEFAULT 4 CHECK(limite_emprestimos > 0),
 prazo_dias INTEGER NOT NULL DEFAULT 7 CHECK(prazo_dias > 0),
 multa_diaria_centavos INTEGER NOT NULL DEFAULT 100 CHECK(multa_diaria_centavos >= 0)
);
CREATE TABLE editora (
 id_editora INTEGER PRIMARY KEY, nome TEXT NOT NULL, cnpj TEXT UNIQUE,
 endereco TEXT, telefone TEXT, email TEXT
);
CREATE TABLE categoria (
 id_categoria INTEGER PRIMARY KEY, nome TEXT NOT NULL UNIQUE, descricao TEXT
);
CREATE TABLE autor (
 id_autor INTEGER PRIMARY KEY, nome TEXT NOT NULL, nacionalidade TEXT, nascimento TEXT, biografia TEXT
);
CREATE TABLE livro (
 id_livro INTEGER PRIMARY KEY, titulo TEXT NOT NULL, isbn TEXT UNIQUE,
 ano_publicacao INTEGER CHECK(ano_publicacao > 0), edicao INTEGER DEFAULT 1 CHECK(edicao > 0),
 paginas INTEGER CHECK(paginas > 0), idioma TEXT NOT NULL DEFAULT 'Português',
 id_editora INTEGER NOT NULL REFERENCES editora ON UPDATE CASCADE ON DELETE RESTRICT,
 id_categoria INTEGER NOT NULL REFERENCES categoria ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE livro_autor (
 id_livro INTEGER NOT NULL REFERENCES livro ON UPDATE CASCADE ON DELETE CASCADE,
 id_autor INTEGER NOT NULL REFERENCES autor ON UPDATE CASCADE ON DELETE RESTRICT,
 ordem INTEGER NOT NULL DEFAULT 1 CHECK(ordem > 0),
 PRIMARY KEY(id_livro,id_autor), UNIQUE(id_livro,ordem)
);
CREATE TABLE exemplar (
 id_exemplar INTEGER PRIMARY KEY, tombo TEXT NOT NULL UNIQUE, conservacao TEXT,
 apto INTEGER NOT NULL DEFAULT 1 CHECK(apto IN (0,1)),
 id_livro INTEGER NOT NULL REFERENCES livro ON UPDATE CASCADE ON DELETE RESTRICT,
 id_biblioteca INTEGER NOT NULL REFERENCES biblioteca ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE leitor (
 id_leitor INTEGER PRIMARY KEY, nome TEXT NOT NULL, cpf TEXT NOT NULL UNIQUE
 CHECK(length(cpf)=11 AND cpf NOT GLOB '*[^0-9]*'),
 email TEXT, telefone TEXT, endereco TEXT, nascimento TEXT,
 data_cadastro TEXT NOT NULL DEFAULT CURRENT_DATE,
 ativo INTEGER NOT NULL DEFAULT 1 CHECK(ativo IN (0,1))
);
CREATE TABLE funcionario (
 id_funcionario INTEGER PRIMARY KEY, nome TEXT NOT NULL, cpf TEXT NOT NULL UNIQUE
 CHECK(length(cpf)=11 AND cpf NOT GLOB '*[^0-9]*'),
 cargo TEXT NOT NULL, email TEXT, telefone TEXT, contratacao TEXT,
 autorizado INTEGER NOT NULL DEFAULT 1 CHECK(autorizado IN (0,1)),
 id_biblioteca INTEGER NOT NULL REFERENCES biblioteca ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE emprestimo (
 id_emprestimo INTEGER PRIMARY KEY,
 id_leitor INTEGER NOT NULL REFERENCES leitor ON UPDATE CASCADE ON DELETE RESTRICT,
 id_exemplar INTEGER NOT NULL REFERENCES exemplar ON UPDATE CASCADE ON DELETE RESTRICT,
 id_funcionario INTEGER NOT NULL REFERENCES funcionario ON UPDATE CASCADE ON DELETE RESTRICT,
 data_retirada TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(date(data_retirada,'+0 days') IS data_retirada),
 data_prevista TEXT NOT NULL CHECK(date(data_prevista,'+0 days') IS data_prevista AND data_prevista >= data_retirada),
 data_devolucao TEXT CHECK(data_devolucao IS NULL OR
 (date(data_devolucao,'+0 days') IS data_devolucao AND data_devolucao >= data_retirada))
);
CREATE UNIQUE INDEX um_emprestimo_aberto_por_exemplar ON emprestimo(id_exemplar)
 WHERE data_devolucao IS NULL;
CREATE TABLE reserva (
 id_reserva INTEGER PRIMARY KEY,
 id_leitor INTEGER NOT NULL REFERENCES leitor ON UPDATE CASCADE ON DELETE RESTRICT,
 id_livro INTEGER NOT NULL REFERENCES livro ON UPDATE CASCADE ON DELETE RESTRICT,
 id_biblioteca INTEGER NOT NULL REFERENCES biblioteca ON UPDATE CASCADE ON DELETE RESTRICT,
 data_reserva TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(date(data_reserva,'+0 days') IS data_reserva),
 data_validade TEXT NOT NULL CHECK(date(data_validade,'+0 days') IS data_validade AND data_validade >= data_reserva),
 situacao TEXT NOT NULL DEFAULT 'aguardando'
 CHECK(situacao IN ('aguardando','disponivel','cancelada','atendida','expirada')),
 id_exemplar INTEGER REFERENCES exemplar ON UPDATE CASCADE ON DELETE RESTRICT,
 CHECK((situacao <> 'disponivel' OR id_exemplar IS NOT NULL)
 AND (situacao <> 'aguardando' OR id_exemplar IS NULL))
);
CREATE UNIQUE INDEX uma_reserva_por_exemplar ON reserva(id_exemplar) WHERE situacao='disponivel';
CREATE UNIQUE INDEX uma_reserva_por_leitor ON reserva(id_leitor,id_livro,id_biblioteca)
 WHERE situacao IN ('aguardando','disponivel');
CREATE TABLE multa (
 id_multa INTEGER PRIMARY KEY,
 id_emprestimo INTEGER NOT NULL UNIQUE REFERENCES emprestimo ON UPDATE CASCADE ON DELETE RESTRICT,
 valor_centavos INTEGER NOT NULL CHECK(typeof(valor_centavos)='integer' AND valor_centavos > 0),
 motivo TEXT NOT NULL DEFAULT 'Atraso na devolução',
 data_geracao TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(date(data_geracao,'+0 days') IS data_geracao),
 data_pagamento TEXT CHECK(data_pagamento IS NULL OR
 (date(data_pagamento,'+0 days') IS data_pagamento AND data_pagamento >= data_geracao))
);
CREATE VIEW disponibilidade_exemplar AS
SELECT x.*, CASE WHEN EXISTS (SELECT 1 FROM emprestimo e WHERE e.id_exemplar=x.id_exemplar
 AND e.data_devolucao IS NULL) THEN 'emprestado'
 WHEN x.apto=0 THEN 'indisponivel'
 WHEN EXISTS (SELECT 1 FROM reserva r WHERE r.id_exemplar=x.id_exemplar AND r.situacao='disponivel'
 AND r.data_validade >= date('now','localtime')) THEN 'reservado'
 ELSE 'disponivel' END AS situacao
FROM exemplar x;
COMMIT;

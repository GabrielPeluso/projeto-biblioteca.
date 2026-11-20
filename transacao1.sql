-- Demonstração: confirmar uma categoria e desfazer outra usando SAVEPOINT.
-- Execute em uma cópia inicial de biblioteca.db.
SELECT COUNT(*) AS antes FROM categoria;
BEGIN;
INSERT INTO categoria(nome) VALUES ('Demonstração confirmada');
SAVEPOINT etapa_opcional;
INSERT INTO categoria(nome) VALUES ('Demonstração descartada');
ROLLBACK TO etapa_opcional;
RELEASE etapa_opcional;
COMMIT;
SELECT nome FROM categoria WHERE nome LIKE 'Demonstração%' ORDER BY nome;
-- Esperado: somente Demonstração confirmada.

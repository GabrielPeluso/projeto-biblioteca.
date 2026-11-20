-- Consulta 1
-- Objetivo: Estatísticas gerais do acervo e do histórico de empréstimos.
WITH copias AS (
 SELECT l.id_livro, COUNT(x.id_exemplar) AS total
 FROM livro l LEFT JOIN exemplar x ON x.id_livro=l.id_livro GROUP BY l.id_livro
)
SELECT COUNT(*) AS livros, SUM(total) AS exemplares, ROUND(AVG(total),2) AS media,
 MIN(total) AS minimo, MAX(total) AS maximo,
 (SELECT COUNT(*) FROM emprestimo) AS emprestimos
FROM copias;

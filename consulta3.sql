-- Consulta 3
-- Objetivo: Catálogo completo, inclusive títulos sem empréstimo.
WITH historico AS (
 SELECT x.id_livro, COUNT(*) AS retiradas FROM emprestimo e
 JOIN exemplar x ON x.id_exemplar=e.id_exemplar GROUP BY x.id_livro
)
SELECT l.titulo, COALESCE(h.retiradas,0) AS retiradas
FROM livro l LEFT JOIN historico h ON h.id_livro=l.id_livro ORDER BY l.titulo ASC;

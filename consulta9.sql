-- Consulta 9
-- Objetivo: Ranking dos livros que já foram emprestados.
WITH ranking AS (
 SELECT x.id_livro,COUNT(*) AS retiradas FROM emprestimo e
 JOIN exemplar x ON x.id_exemplar=e.id_exemplar GROUP BY x.id_livro
)
SELECT l.titulo,r.retiradas FROM ranking r JOIN livro l ON l.id_livro=r.id_livro
ORDER BY r.retiradas DESC,l.titulo ASC;

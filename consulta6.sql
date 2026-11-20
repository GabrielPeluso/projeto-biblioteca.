-- Consulta 6
-- Objetivo: Títulos com mais exemplares que a média do catálogo.
WITH copias AS (
 SELECT l.id_livro,l.titulo,COUNT(x.id_exemplar) AS total
 FROM livro l LEFT JOIN exemplar x ON x.id_livro=l.id_livro
 GROUP BY l.id_livro,l.titulo
)
SELECT titulo,total FROM copias WHERE total>(SELECT AVG(total) FROM copias)
ORDER BY total DESC,titulo ASC;

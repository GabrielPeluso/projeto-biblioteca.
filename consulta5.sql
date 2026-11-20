-- Consulta 5
-- Objetivo: Combinações de categoria e unidade com mais de dois empréstimos.
SELECT c.nome AS categoria, b.nome AS biblioteca, COUNT(*) AS total
FROM emprestimo e JOIN exemplar x ON x.id_exemplar=e.id_exemplar
JOIN livro l ON l.id_livro=x.id_livro JOIN categoria c ON c.id_categoria=l.id_categoria
JOIN biblioteca b ON b.id_biblioteca=x.id_biblioteca
GROUP BY c.nome,b.nome HAVING COUNT(*)>2 ORDER BY total DESC, categoria ASC, biblioteca ASC;

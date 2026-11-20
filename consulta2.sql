-- Consulta 2
-- Objetivo: Exemplares retirados e respectivos leitores.
SELECT e.id_emprestimo, r.nome AS leitor, x.tombo, l.titulo
FROM emprestimo e INNER JOIN leitor r ON r.id_leitor=e.id_leitor
INNER JOIN exemplar x ON x.id_exemplar=e.id_exemplar
INNER JOIN livro l ON l.id_livro=x.id_livro
ORDER BY e.id_emprestimo ASC;

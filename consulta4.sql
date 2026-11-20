-- Consulta 4
-- Objetivo: Leitores com mais de dois empréstimos no histórico.
SELECT r.nome, COUNT(*) AS total
FROM leitor r JOIN emprestimo e ON e.id_leitor=r.id_leitor
GROUP BY r.id_leitor, r.nome HAVING COUNT(*)>2 ORDER BY total DESC, r.nome ASC;

-- Consulta 7
-- Objetivo: Leitores que já fizeram pelo menos um empréstimo.
SELECT r.id_leitor,r.nome FROM leitor r
WHERE EXISTS (SELECT 1 FROM emprestimo e WHERE e.id_leitor=r.id_leitor)
ORDER BY r.nome ASC;

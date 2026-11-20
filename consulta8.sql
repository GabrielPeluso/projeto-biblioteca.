-- Consulta 8
-- Objetivo: Livros de categorias que já tiveram alguma reserva.
SELECT titulo FROM livro WHERE id_categoria IN (
 SELECT l.id_categoria FROM reserva r JOIN livro l ON l.id_livro=r.id_livro
) ORDER BY titulo ASC;

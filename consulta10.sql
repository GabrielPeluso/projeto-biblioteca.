-- Consulta 10
-- Objetivo: Situação em 19/11/2026, data de referência da demonstração.
SELECT id_emprestimo, data_prevista, data_devolucao,
 CASE WHEN data_devolucao IS NOT NULL AND data_devolucao>data_prevista THEN 'Devolvido com atraso'
      WHEN data_devolucao IS NOT NULL THEN 'Devolvido no prazo'
      WHEN data_prevista<'2026-11-19' THEN 'Em atraso'
      ELSE 'Em aberto no prazo' END AS situacao
FROM emprestimo ORDER BY data_prevista ASC,id_emprestimo ASC;

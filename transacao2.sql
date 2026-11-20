-- Demonstração: confirmar uma alteração e desfazer integralmente outra transação.
-- Execute em uma cópia inicial de biblioteca.db.
SELECT id_multa,data_pagamento FROM multa WHERE id_multa IN (2,4);
BEGIN;
SAVEPOINT registrar_pagamento;
UPDATE multa SET data_pagamento='2026-11-19' WHERE id_multa=2;
RELEASE registrar_pagamento;
COMMIT;
BEGIN;
UPDATE multa SET data_pagamento='2026-11-19' WHERE id_multa=4;
ROLLBACK;
SELECT id_multa,data_pagamento FROM multa WHERE id_multa IN (2,4) ORDER BY id_multa;
-- Esperado: multa 2 paga e multa 4 ainda pendente.

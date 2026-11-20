# Roteiro da apresentação

Duração total de 10 minutos. Abra o arquivo biblioteca.db antes da apresentação e use uma cópia para demonstrar transações.

## 1. Sistema de Gerenciamento de Bibliotecas · 0:30

Apresente o projeto e diga que a demonstração acompanha o trajeto de uma cópia física, do cadastro ao empréstimo e à devolução.

## 2. O cenário · 1:00

Explique o problema de usar papel e planilhas. Dê o exemplo de duas unidades com exemplares diferentes do mesmo título.

## 3. Requisitos e regras · 1:00

Cite leitor, bibliotecário, auxiliar, administrador e diretor. Explique como a chave estrangeira, o índice único e as validações operacionais atuam.

## 4. Modelo conceitual · 1:15

Use a figura para mostrar Livro, Exemplar e Biblioteca. Depois siga Livro–Autor e explique a cardinalidade muitos para muitos.

## 5. Modelo lógico · 1:15

Aponte as três FKs de empréstimo e a PK composta de Livro–Autor. Explique por que multa referencia o empréstimo e como se chega ao leitor.

## 6. Banco SQLite · 1:30

Abra biblioteca.db. Mostre a lista de tabelas e rode PRAGMA foreign_key_check e PRAGMA integrity_check.

## 7. Demonstração SQL · 2:30

Execute as consultas 1, 4 e 10. Explique GROUP BY e HAVING na 4 e CASE e NULL na 10. Se houver tempo ou solicitação, abra a cópia de teste e execute a transação 1.

## 8. Conclusão · 1:00

Retome a distinção entre livro e exemplar e explique a decisão de usar um empréstimo por cópia física. Esteja pronta para demonstrar qualquer uma das dez consultas.

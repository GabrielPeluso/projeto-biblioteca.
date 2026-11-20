# Sistema de Gerenciamento de Bibliotecas

Projeto final de CIN8003 — Bancos de Dados e Aplicações | UFSC. O cenário foi validado pelo professor.

## 1. Cenário e requisitos

1. [Descrição do cenário](descricao_cenario.txt)
2. [Documento de requisitos](modelo_requisitos.pdf) com cinco stakeholders, dez requisitos funcionais e 19 regras de negócio.

## 2. Modelagem

1. [Modelo conceitual](modelo_conceitual.png). A indicação junto de cada ponta expressa quantas ocorrências daquela entidade podem se associar a uma ocorrência do outro lado.
2. [Modelo lógico](modelo_logico.png). PK identifica a linha, FK referencia outra tabela e NN indica campo obrigatório. As restrições e os valores padrão aparecem no DDL.

Livro e Autor formam uma relação muitos para muitos por meio de Livro–Autor. Cada Livro pertence a uma Categoria e a uma Editora. Cada Exemplar pertence a um Livro e a uma Biblioteca. Cada Funcionário pertence a uma Biblioteca. O Empréstimo liga um Leitor, um Funcionário e um Exemplar. A Reserva liga um Leitor, um Livro e uma Biblioteca e pode ter um Exemplar separado. A Multa vincula-se a um único Empréstimo, que pode ter zero ou uma multa.

As 12 tabelas usam um empréstimo por exemplar, uma categoria por livro e reserva por título e unidade. O cadastro de leitor atende à rede. Quantidade de cópias, disponibilidade e situação de pagamento podem ser derivadas dos registros. O bloqueio, a autorização, a renovação e a movimentação da fila são validações da operação descritas no documento de requisitos.

## 3. Criar, preencher e conferir o banco

1. Abra [SQLite Online](https://sqliteonline.com/) e selecione SQLite. Para testar o editor, rode `SELECT 'Meu primeiro comando SQL' AS mensagem;`.
2. Crie um banco vazio. Execute [script_ddl.sql](script_ddl.sql), que já habilita as chaves estrangeiras na conexão.
3. Execute [script_dml.sql](script_dml.sql) uma vez para inserir os dados fictícios.
4. Confira as tabelas, as chaves estrangeiras e a integridade com os comandos abaixo.
5. Alternativamente, abra o [biblioteca.db](biblioteca.db) já preenchido. Repita as verificações após reabrir o banco. Em uma nova conexão de escrita execute `PRAGMA foreign_keys = ON;`.

```sql
SELECT name FROM sqlite_master
WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name;
SELECT COUNT(*) AS livros FROM livro;
PRAGMA foreign_key_check;
PRAGMA integrity_check;
```

São esperadas 12 tabelas, 20 livros, nenhuma linha no teste de chaves estrangeiras e `ok` no teste de integridade.

| Tabela | Registros |
|---|---:|
| biblioteca | 2 |
| editora | 5 |
| categoria | 7 |
| autor | 11 |
| livro | 20 |
| livro_autor | 21 |
| exemplar | 30 |
| leitor | 12 |
| funcionario | 5 |
| emprestimo | 15 |
| reserva | 7 |
| multa | 4 |

## 4. Consultas e transações

Abra o banco preenchido e execute uma consulta por vez. A consulta 10 usa 19/11/2026 como data de referência para reproduzir a demonstração.

| Arquivo | Objetivo | Linhas no banco entregue |
|---|---|---:|
| [consulta1.sql](consulta1.sql) | Estatísticas gerais do acervo e do histórico de empréstimos. | 1 |
| [consulta2.sql](consulta2.sql) | Exemplares retirados e respectivos leitores. | 15 |
| [consulta3.sql](consulta3.sql) | Catálogo completo, inclusive títulos sem empréstimo. | 20 |
| [consulta4.sql](consulta4.sql) | Leitores com mais de dois empréstimos no histórico. | 2 |
| [consulta5.sql](consulta5.sql) | Combinações de categoria e unidade com mais de dois empréstimos. | 1 |
| [consulta6.sql](consulta6.sql) | Títulos com mais exemplares que a média do catálogo. | 5 |
| [consulta7.sql](consulta7.sql) | Leitores que já fizeram pelo menos um empréstimo. | 11 |
| [consulta8.sql](consulta8.sql) | Livros de categorias que já tiveram alguma reserva. | 15 |
| [consulta9.sql](consulta9.sql) | Ranking dos livros que já foram emprestados. | 14 |
| [consulta10.sql](consulta10.sql) | Situação em 19/11/2026, data de referência da demonstração. | 15 |

Cobertura dos recursos do guia

- Consulta 1 usa COUNT, SUM, AVG, MIN e MAX.
- Consulta 2 faz INNER JOIN entre quatro tabelas.
- Consulta 3 usa LEFT JOIN e COALESCE. Consulta 10 trata NULL com CASE.
- Consultas 4 e 5 usam HAVING. Consulta 5 agrupa por categoria e biblioteca.
- Consultas 6, 7 e 8 incluem, respectivamente, subconsulta escalar, EXISTS e IN.
- Consulta 9 usa CTE e ordenação descendente. Consulta 10 usa ordenação ascendente.

Execute [transacao1.sql](transacao1.sql) e [transacao2.sql](transacao2.sql) em cópias separadas do banco inicial. A primeira confirma uma categoria e desfaz outra até um SAVEPOINT. A segunda confirma o pagamento da multa 2 e desfaz o pagamento da multa 4. Os SELECTs permitem conferir os efeitos.

## 5. Entrega e apresentação

- [Links de apoio](links.txt)
- [Apresentação](apresentacao.pdf), com oito slides
- [Roteiro de apresentação e demonstração](roteiro_apresentacao.md), com duração de 10 minutos

Verificação local concluída no SQLite. Para a entrega acadêmica, conferir os arquivos e o endereço do repositório no GitHub, enviar o link ao professor conforme a orientação da disciplina e ensaiar a demonstração com o banco aberto.

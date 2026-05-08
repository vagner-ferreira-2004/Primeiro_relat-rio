USE sisgesc;

-- GESTAO DE TRANSACOES

START TRANSACTION;
    -- Registrar o pagamento (4 corresponde a PIX)
    INSERT IGNORE INTO pagamentos (pk_mensalidade, valor_pago, pk_forma_pagamento) 
    VALUES (2, 450.00, 4);

    -- Atualizar o status da mensalidade
    UPDATE mensalidades SET situacao_mensalidade = 'Paga' WHERE pk_mensalidade = 2;

-- ERRO
ROLLBACK;


-- Simulacao de Erro com Transacao Falsa
START TRANSACTION;
    INSERT INTO pagamentos (pk_mensalidade, numero_transacao, valor_pago, pk_forma_pagamento)
    VALUES (2, 'REC-FALSO-001', 850.00, 4);
ROLLBACK; 
SELECT * FROM pagamentos WHERE numero_transacao = 'REC-FALSO-001'; 


-- Pagamento com Sucesso
START TRANSACTION;
    INSERT INTO pagamentos (pk_mensalidade, numero_transacao, valor_pago, pk_forma_pagamento)
    VALUES (2, 'REC-VERDADEIRO-002', 850.00, 5); -- 5 corresponde a BOLETO
COMMIT; 
SELECT * FROM pagamentos WHERE numero_transacao = 'REC-VERDADEIRO-002'; 


-- Falha Critica no Meio do Processo
START TRANSACTION;
    INSERT IGNORE INTO pagamentos (pk_mensalidade, numero_transacao, valor_pago, pk_forma_pagamento)
    VALUES (2, 'REC-FALHA-CARTAO-003', 850.00, 2); -- 2 corresponde a CARTAO DE CREDITO
    
    -- Atualizaria a mensalidade
    UPDATE mensalidades
    SET situacao_mensalidade = 'Paga'
    WHERE pk_mensalidade = 2;
    
ROLLBACK; 
SELECT * FROM pagamentos WHERE numero_transacao = 'REC-FALHA-CARTAO-003'; 
SELECT situacao_mensalidade FROM mensalidades WHERE pk_mensalidade = 2;



-- CRIAÇÃO DE VISOES (VIEWS)

-- Lista de Alunos 
CREATE OR REPLACE VIEW vw_lista_alunos AS
SELECT 
    a.ra_aluno AS 'RA', 
    p.nome_pessoa AS 'Nome do Aluno', 
    a.situacao_aluno AS 'Status'
FROM alunos a
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa;


-- Lista de Professores 
CREATE OR REPLACE VIEW vw_lista_professores AS
SELECT 
    prof.pk_docente AS 'Cod Docente', 
    p.nome_pessoa AS 'Nome do Professor', 
    t.nome_titulacao AS 'Titulacao'
FROM professores prof
JOIN funcionarios f ON prof.matricula_rh = f.matricula_rh
JOIN pessoas p ON f.pk_pessoa = p.pk_pessoa
JOIN titulacoes t ON prof.pk_titulacao = t.pk_titulacao;


-- Ocupaçao das Turmas
CREATE OR REPLACE VIEW vw_ocupacao_turmas AS
SELECT 
    t.pk_turma AS 'Código',
    d.nome_disciplina AS 'Disciplina',
    p_pess.nome_pessoa AS 'Professor',
    COUNT(i.ra_aluno) AS 'Alunos Matriculados'
FROM turmas t
JOIN disciplinas d ON t.pk_disciplina = d.pk_disciplina
JOIN professores prof ON t.pk_docente = prof.pk_docente
JOIN funcionarios f ON prof.matricula_rh = f.matricula_rh
JOIN pessoas p_pess ON f.pk_pessoa = p_pess.pk_pessoa
LEFT JOIN inscricoes i ON t.pk_turma = i.pk_turma
GROUP BY t.pk_turma, d.nome_disciplina, p_pess.nome_pessoa;


-- Lista de Adimplentes 
CREATE OR REPLACE VIEW vw_alunos_adimplentes AS
SELECT 
    a.ra_aluno AS 'RA',
    p.nome_pessoa AS 'Aluno Adimplente'
FROM alunos a
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa
WHERE a.ra_aluno IN (
    SELECT c.ra_aluno
    FROM contrato_financeiro c
    JOIN mensalidades m ON c.pk_contrato = m.pk_contrato
    JOIN pagamentos pag ON m.pk_mensalidade = pag.pk_mensalidade
    GROUP BY c.ra_aluno
    HAVING SUM(pag.valor_pago) >= 800.00
);


-- Lista de Inadimplencia 
CREATE OR REPLACE VIEW vw_alunos_devedores AS
SELECT 
    a.ra_aluno AS 'RA',
    p.nome_pessoa AS 'Nome',
    m.valor_parcela AS 'Valor Pendente',
    m.data_vencimento AS 'Vencimento'
FROM alunos a
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa
JOIN contrato_financeiro c ON a.ra_aluno = c.ra_aluno
JOIN mensalidades m ON c.pk_contrato = m.pk_contrato
WHERE m.situacao_mensalidade = 'Pendente'
  AND m.data_vencimento < CURDATE();


-- CONSULTAS AVANÇADAS

-- Alunos ATIVOS que não realizaram nenhum pagamento no ano de 2026
SELECT 
    a.ra_aluno AS 'RA',
    p.nome_pessoa AS 'Aluno com Risco de Inadimplencia'
FROM alunos a
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa
WHERE a.situacao_aluno = 'Ativo'
  AND a.ra_aluno NOT IN (
      SELECT c.ra_aluno
      FROM contrato_financeiro c
      JOIN mensalidades m ON c.pk_contrato = m.pk_contrato
      JOIN pagamentos pag ON m.pk_mensalidade = pag.pk_mensalidade
      WHERE pag.data_pagamento BETWEEN '2026-01-01' AND '2026-12-31'
  );


-- Painel de Lucro 
SELECT 
    YEAR(pag.data_pagamento) AS 'Ano',
    MONTH(pag.data_pagamento) AS 'Mes',
    DAYOFWEEK(pag.data_pagamento) AS 'Dia da Semana (1=Dom)',
    fp.nome_forma AS 'Metodo',
    SUM(pag.valor_pago) AS 'Total Arrecadado'
FROM pagamentos pag
JOIN formas_pagamento fp ON pag.pk_forma_pagamento = fp.pk_forma_pagamento
WHERE pag.data_pagamento BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY YEAR(pag.data_pagamento), MONTH(pag.data_pagamento), DAYOFWEEK(pag.data_pagamento), fp.nome_forma
ORDER BY Ano DESC, Mes DESC, `Total Arrecadado` DESC;


-
-- VISOES COMPLEMENTARES 

-- Custo total por funcionario
CREATE OR REPLACE VIEW vw_custo_funcionarios AS
SELECT 
    f.matricula_rh,
    p.nome_pessoa,
    c.nome_cargo,
    t.nome_titulacao,
    sf.salario_base,
    sf.salario_bruto,
    sf.custo_total_empresa,
    sm.valor_salario_minimo AS salario_minimo_ref,
    sf.quantidade_salarios_minimos,
    f.situacao_funcionario
FROM funcionarios f
JOIN pessoas p ON f.pk_pessoa = p.pk_pessoa

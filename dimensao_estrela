USE sisgesc;

-- RESET DO AMBIENTE ANALÍTICO (OLAP)


-- A tabela Fato deve ser excluída primeiro devido às chaves estrangeiras
DROP TABLE IF EXISTS fato_financeiro;
DROP TABLE IF EXISTS dim_tempo;
DROP TABLE IF EXISTS dim_aluno;
DROP TABLE IF EXISTS dim_curso;
DROP TABLE IF EXISTS dim_unidade;


-- CRIACAO DAS DIMENSOES


-- Dimensao Tempo (Análise por periodos)
CREATE TABLE dim_tempo (
    sk_tempo INT AUTO_INCREMENT PRIMARY KEY, 
    data_completa DATE NOT NULL UNIQUE,
    ano INT NOT NULL,
    mes INT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    trimestre INT NOT NULL,
    semestre INT NOT NULL
) ENGINE=InnoDB;

-- Dimensao Aluno 
CREATE TABLE dim_aluno (
    sk_aluno INT AUTO_INCREMENT PRIMARY KEY,
    ra_aluno_oltp INT NOT NULL,              
    nome_aluno VARCHAR(150) NOT NULL,
    cidade_aluno VARCHAR(100),
    estado_aluno CHAR(2)
) ENGINE=InnoDB;

-- Dimensao Curso 
CREATE TABLE dim_curso (
    sk_curso INT AUTO_INCREMENT PRIMARY KEY, 
    pk_curso_oltp INT NOT NULL,
    nome_curso VARCHAR(150) NOT NULL
) ENGINE=InnoDB;

-- Dimensao Unidade 
CREATE TABLE dim_unidade (
    sk_unidade INT AUTO_INCREMENT PRIMARY KEY,
    pk_endereco_oltp INT NOT NULL,
    cidade_unidade VARCHAR(100) NOT NULL,
    estado_unidade CHAR(2) NOT NULL
) ENGINE=InnoDB;


-- CRIACAO DA TABELA FATO

CREATE TABLE fato_financeiro (
    sk_financeiro INT AUTO_INCREMENT PRIMARY KEY,
    sk_tempo INT NOT NULL,
    sk_aluno INT NOT NULL,
    sk_curso INT NOT NULL,
    sk_unidade INT NOT NULL,
    valor_recebido DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT fk_fato_tempo FOREIGN KEY (sk_tempo) REFERENCES dim_tempo(sk_tempo),
    CONSTRAINT fk_fato_aluno FOREIGN KEY (sk_aluno) REFERENCES dim_aluno(sk_aluno),
    CONSTRAINT fk_fato_curso FOREIGN KEY (sk_curso) REFERENCES dim_curso(sk_curso),
    CONSTRAINT fk_fato_unidade FOREIGN KEY (sk_unidade) REFERENCES dim_unidade(sk_unidade)
) ENGINE=InnoDB;


-- PROCESSO ETL 

-- Carga da Dimensao Tempo
INSERT INTO dim_tempo (data_completa, ano, mes, nome_mes, trimestre, semestre)
SELECT DISTINCT 
    DATE(data_pagamento), 
    YEAR(data_pagamento), 
    MONTH(data_pagamento),
    CASE MONTH(data_pagamento)
        WHEN 1 THEN 'Janeiro' WHEN 2 THEN 'Fevereiro' WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'   WHEN 5 THEN 'Maio'      WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'   WHEN 8 THEN 'Agosto'    WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro' WHEN 11 THEN 'Novembro' WHEN 12 THEN 'Dezembro'
    END,
    QUARTER(data_pagamento),
    IF(MONTH(data_pagamento) <= 6, 1, 2)
FROM pagamentos;

-- Carga da Dimensao Aluno
INSERT INTO dim_aluno (ra_aluno_oltp, nome_aluno, cidade_aluno, estado_aluno)
SELECT 
    a.ra_aluno, 
    p.nome_pessoa, 
    e.cidade_endereco, 
    est.sigla_estado
FROM alunos a
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa
JOIN enderecos e ON p.pk_endereco = e.pk_endereco
JOIN estados est ON e.pk_estado = est.pk_estado;

-- Carga da Dimensão Curso
INSERT INTO dim_curso (pk_curso_oltp, nome_curso)
SELECT pk_curso, nome_curso FROM cursos;

-- Carga da Dimensao Unidade
INSERT INTO dim_unidade (pk_endereco_oltp, cidade_unidade, estado_unidade)
SELECT 
    e.pk_endereco, 
    e.cidade_endereco, 
    est.sigla_estado 
FROM enderecos e
JOIN estados est ON e.pk_estado = est.pk_estado;

-- Carga da Tabela Fato
INSERT INTO fato_financeiro (sk_tempo, sk_aluno, sk_curso, sk_unidade, valor_recebido)
SELECT 
    dt.sk_tempo, 
    da.sk_aluno, 
    dc.sk_curso, 
    du.sk_unidade, 
    pag.valor_pago
FROM pagamentos pag
JOIN mensalidades m ON pag.pk_mensalidade = m.pk_mensalidade
JOIN contrato_financeiro c ON m.pk_contrato = c.pk_contrato
JOIN alunos a ON c.ra_aluno = a.ra_aluno
JOIN pessoas p ON a.pk_pessoa = p.pk_pessoa
JOIN dim_tempo dt ON DATE(pag.data_pagamento) = dt.data_completa
JOIN dim_aluno da ON a.ra_aluno = da.ra_aluno_oltp
JOIN dim_curso dc ON a.pk_curso = dc.pk_curso_oltp
JOIN dim_unidade du ON p.pk_endereco = du.pk_endereco_oltp;


-- RELATORIOS E VALIDACAO DE INTEGRIDADE

-- Validacao de Totais
SELECT 'SISTEMA (OLTP)' AS Origem, SUM(valor_pago) AS Total FROM pagamentos
UNION ALL
SELECT 'DW ESTRELA (OLAP)' AS Origem, SUM(valor_recebido) AS Total FROM fato_financeiro;

-- Faturamento por Curso e Semestre
SELECT 
    t.ano, 
    t.semestre, 
    c.nome_curso,
    SUM(f.valor_recebido) AS faturamento_total
FROM fato_financeiro f
JOIN dim_tempo t ON f.sk_tempo = t.sk_tempo
JOIN dim_curso c ON f.sk_curso = c.sk_curso
GROUP BY t.ano, t.semestre, c.nome_curso
ORDER BY faturamento_total DESC;

USE sisgesc;


-- DADOS DE REFERENCIA 


INSERT IGNORE INTO salario_minimo (valor_salario_minimo, data_vigencia_inicio, data_vigencia_fim, decreto_lei) VALUES 
(1412.00, '2024-01-01', NULL, 'Lei 14.663/2023'), 
(1320.00, '2023-01-01', '2023-12-31', 'Lei 14.442/2022'), 
(1212.00, '2022-01-01', '2022-12-31', 'Lei 14.158/2021');

INSERT INTO estados (sigla_estado, nome_estado, regiao) VALUES
('AC', 'Acre', 'Norte'), ('AL', 'Alagoas', 'Nordeste'), ('AP', 'Amapa', 'Norte'),
('AM', 'Amazonas', 'Norte'), ('BA', 'Bahia', 'Nordeste'), ('CE', 'Ceara', 'Nordeste'),
('DF', 'Distrito Federal', 'Centro-Oeste'), ('ES', 'Espirito Santo', 'Sudeste'),
('GO', 'Goias', 'Centro-Oeste'), ('MA', 'Maranhao', 'Nordeste'), ('MT', 'Mato Grosso', 'Centro-Oeste'),
('MS', 'Mato Grosso do Sul', 'Centro-Oeste'), ('MG', 'Minas Gerais', 'Sudeste'),
('PA', 'Para', 'Norte'), ('PB', 'Paraiba', 'Nordeste'), ('PR', 'Parana', 'Sul'),
('PE', 'Pernambuco', 'Nordeste'), ('PI', 'Piaui', 'Nordeste'), ('RJ', 'Rio de Janeiro', 'Sudeste'),
('RN', 'Rio Grande do Norte', 'Nordeste'), ('RS', 'Rio Grande do Sul', 'Sul'),
('RO', 'Rondonia', 'Norte'), ('RR', 'Roraima', 'Norte'), ('SC', 'Santa Catarina', 'Sul'),
('SP', 'Sao Paulo', 'Sudeste'), ('SE', 'Sergipe', 'Nordeste'), ('TO', 'Tocantins', 'Norte');

INSERT INTO modalidades_ensino (nome_modalidade, descricao_modalidade) VALUES
('Presencial', 'Aulas 100% presenciais'),
('EAD', 'Ensino a distancia'),
('Semi-Presencial', 'Encontros presenciais periodicos');

INSERT INTO niveis_ensino (nome_nivel, descricao_nivel) VALUES
('Tecnico', 'Curso tecnico de nivel medio'),
('Graduacao', 'Curso superior de graduacao');

INSERT INTO areas_atuacao (codigo_area, nome_area, descricao_area) VALUES
('AREA-TI', 'Tecnologia da Informação', 'Computacao e sistemas'),
('AREA-ADM', 'Administração', 'Gestao e negocios'),
('AREA-DSG', 'Design', 'Artes visuais e design');

INSERT INTO formas_ingresso (nome_forma, descricao_forma) VALUES
('SISU', 'Sistema de Selecao Unificada'),
('PROUNI', 'Programa Universidade para Todos'),
('Vestibular', 'Processo seletivo proprio'),
('Transferencia Externa', 'Vindo de outra instituicao');

INSERT INTO tipos_cota (nome_cota, descricao_cota, percentual_reserva) VALUES
('Ampla Concorrencia', 'Sem reserva de vaga', 50.00),
('Escola Publica', 'Estudou em escola publica', 12.50),
('Escola Publica + Renda', 'Escola publica e renda baixa', 12.50);

INSERT INTO formas_pagamento (nome_forma, taxa_operacao, prazo_compensacao) VALUES
('Dinheiro', 0.00, 0),
('Cartao Credito', 2.50, 30),
('Cartao Debito', 1.50, 1),
('PIX', 0.00, 0),
('Boleto', 1.00, 3);

INSERT INTO planos_pagamento (nome_plano, quantidade_parcelas, percentual_desconto, dia_vencimento) VALUES
('A Vista', 1, 10.00, 10),
('Semestral 6x', 6, 0.00, 10),
('Mensal 12x', 12, 0.00, 10);

INSERT IGNORE INTO carga_horaria (descricao, horas_totais, horas_semanais, horas_mensais, tipo_carga) VALUES 
('Graduação TI - Integral', 3200, 20, 80, 'Semanal'),    
('Graduação ADM - Noturno', 3000, 15, 60, 'Semanal'),   
('Tecnólogo - Semi-presencial', 1600, 10, 40, 'Semanal'); 


-- INFRAESTRUTURA ACADEMICA E CURSOS

-- Preparando Semestres para os contratos funcionarem
INSERT INTO anos_letivos (ano, data_inicio, data_fim) VALUES 
(2025, '2025-02-01', '2025-12-15'),
(2026, '2026-02-01', '2026-12-15');

INSERT INTO semestres_letivos (pk_ano_letivo, numero_semestre, data_inicio, data_fim) VALUES 
(1, 1, '2025-02-01', '2025-07-10'),
(2, 1, '2026-02-01', '2026-07-10');

INSERT IGNORE INTO cursos (codigo_curso, nome_curso, pk_modalidade, pk_nivel, pk_area_atuacao, fk_carga_horaria) VALUES 
('CC01', 'Ciencia da Computacao', 1, 2, 1, 1), 
('SI01', 'Sistemas de Informacao', 1, 2, 1, 1), 
('ES01', 'Engenharia de Software', 1, 2, 1, 1), 
('ADM01', 'Administracao', 1, 2, 2, 2), 
('DG01', 'Design Grafico', 3, 1, 3, 3);


--  PESSOAS, ENDEREÇOS E INGRESSO

--  25 corresponde a 'SP' inserido na tabela de estados
INSERT INTO enderecos (cep, logradouro, numero_endereco, bairro_endereco, cidade_endereco, pk_estado) VALUES 
('01001-000', 'Rua das Flores', '123', 'Centro', 'São Paulo', 25),
('01310-100', 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 25),
('01305-000', 'Rua Augusta', '456', 'Consolação', 'São Paulo', 25),
('03103-000', 'Rua da Mooca', '789', 'Mooca', 'São Paulo', 25),
('01430-000', 'Av. Brasil', '1000', 'Jardins', 'São Paulo', 25),
('01504-000', 'Rua Vergueiro', '200', 'Liberdade', 'São Paulo', 25),
('01452-000', 'Av. Faria Lima', '3000', 'Itaim Bibi', 'São Paulo', 25),
('03081-000', 'Rua Tuiuti', '55', 'Tatuapé', 'São Paulo', 25),
('01046-010', 'Av. Ipiranga', '200', 'Republica', 'São Paulo', 25),
('04010-000', 'Rua Domingos de Morais', '150', 'Vila Mariana', 'São Paulo', 25);

INSERT IGNORE INTO pessoas (cpf_pessoa, nome_pessoa, data_nascimento, pk_endereco, genero_pessoa, raca_pessoa) VALUES 
('111.222.333-44', 'Vitor Ferreira', '2001-05-15', 1, 'Masculino', 'Parda'),        
('555.666.777-88', 'Thiago Cavalcante', '2000-08-22', 2, 'Masculino', 'Branca'),    
('999.888.777-66', 'Carlos Inadimplente', '1999-11-10', 3, 'Masculino', 'Preta'),  
('123.123.123-11', 'Ana Beatriz', '2002-01-30', 4, 'Feminino', 'Branca'),          
('321.321.321-22', 'Lucas Martins', '1998-04-12', 5, 'Masculino', 'Parda'),        
('444.555.666-77', 'Mariana Silva', '2001-07-25', 6, 'Feminino', 'Branca'),        
('888.999.000-11', 'Pedro Almeida', '2000-12-05', 7, 'Masculino', 'Indigena'),        
('111.000.111-22', 'Fernanda Lima', '2003-03-18', 8, 'Feminino', 'Amarela'),        
('222.000.222-33', 'Ricardo Alves', '1997-09-09', 9, 'Masculino', 'Branca'),        
('333.000.333-44', 'Juliana Costa', '2002-06-14', 10, 'Feminino', 'Parda');

INSERT IGNORE INTO dados_ingresso (pk_forma_ingresso, pk_tipo_cota, pontuacao_vestibular, pontuacao_enem, classificacao, ano_ingresso, semestre_ingresso) VALUES 
(3, 1, 750.50, NULL, 12, 2026, 1), -- Vestibular Privado, Ampla
(1, 2, NULL, 820.00, 5, 2026, 1),  -- SISU, Publica
(2, 3, NULL, 780.25, 2, 2026, 1),  -- PROUNI, Baixa Renda
(4, 1, NULL, NULL, NULL, 2026, 1); -- Transferencia, Ampla



-- MATRICULA DE ALUNOS

INSERT IGNORE INTO alunos (ra_aluno, pk_pessoa, pk_ingresso, pk_curso, data_matricula, situacao_aluno) VALUES 
(1001, 1, 1, 1, '2026-02-10', 'Ativo'), 
(1002, 2, 1, 2, '2026-02-10', 'Ativo'), 
(1003, 3, 2, 3, '2026-02-10', 'Ativo'), 
(1004, 4, 1, 4, '2026-02-10', 'Ativo'), 
(1005, 5, 3, 5, '2026-02-10', 'Cancelado'), 
(1006, 6, 1, 1, '2026-02-10', 'Ativo'), 
(1007, 7, 2, 2, '2026-02-10', 'Trancado'), 
(1008, 8, 1, 3, '2026-02-10', 'Ativo'), 
(1009, 9, 1, 4, '2022-02-10', 'Formado'), 
(1010, 10, 1, 5, '2026-02-10', 'Ativo');


-- FINANCEIRO (CONTRATOS E MENSALIDADES)

INSERT INTO contrato_financeiro (ra_aluno, pk_plano, pk_semestre, valor_total_semestre, valor_final, data_contrato, situacao_contrato) VALUES  
(1001, 2, 2, 2700.00, 2700.00, '2026-01-10', 'Ativo'),    
(1002, 2, 2, 2700.00, 2700.00, '2026-01-10', 'Ativo'),   
(1003, 2, 2, 2700.00, 2700.00, '2026-01-12', 'Ativo'),     
(1004, 2, 2, 5100.00, 5100.00, '2026-01-15', 'Ativo'),     
(1005, 2, 1, 2400.00, 2400.00, '2025-01-10', 'Cancelado'), 
(1006, 2, 2, 3600.00, 3600.00, '2026-01-20', 'Ativo'),     
(1007, 2, 2, 3000.00, 3000.00, '2026-01-25', 'Cancelado'), -- Alterado de 'Trancado' para 'Cancelado'
(1008, 2, 2, 3000.00, 3000.00, '2026-01-28', 'Ativo'),     
(1009, 2, 1, 2100.00, 2100.00, '2025-01-10', 'Quitado'), 
(1010, 2, 2, 3300.00, 3300.00, '2026-01-30', 'Ativo');

INSERT INTO mensalidades (pk_contrato, numero_parcela, valor_parcela, data_vencimento, situacao_mensalidade) VALUES 
-- Vitor (Contrato 1)
(1, 1, 450.00, '2026-02-10', 'Paga'),        
(1, 2, 450.00, '2026-03-10', 'Paga'),        
-- Thiago (Contrato 2)
(2, 1, 450.00, '2026-02-10', 'Paga'),        
(2, 2, 450.00, '2026-03-10', 'Pendente'),    
-- Carlos (Contrato 3)
(3, 1, 450.00, '2026-02-10', 'Atrasada'),  
(3, 2, 450.00, '2026-03-10', 'Atrasada'),   
-- Ana (Contrato 4)
(4, 1, 850.00, '2026-02-15', 'Paga'),      
(4, 2, 850.00, '2026-03-15', 'Paga'),        
(4, 3, 850.00, '2026-04-15', 'Pendente'),   
-- Lucas (Contrato 5)
(5, 1, 400.00, '2026-02-10', 'Cancelada'),  
(5, 2, 400.00, '2026-03-10', 'Cancelada'),   
-- Mariana (Contrato 6)
(6, 1, 600.00, '2026-02-20', 'Paga'),          
(6, 2, 600.00, '2026-03-20', 'Atrasada'),   
-- Pedro (Contrato 7)
(7, 1, 500.00, '2026-02-10', 'Paga'),        
(7, 2, 500.00, '2026-03-10', 'Cancelada'),   
-- Ricardo (Contrato 9)
(9, 1, 350.00, '2025-10-10', 'Atrasada'),   
(9, 2, 350.00, '2025-11-10', 'Paga'),        
-- Juliana (Contrato 10)
(10, 1, 550.00, '2026-02-15', 'Paga'),        
(10, 2, 550.00, '2026-03-15', 'Paga');       

INSERT INTO pagamentos (pk_mensalidade, numero_transacao, valor_pago, data_pagamento, pk_forma_pagamento) VALUES 
(1, 'REC-001', 450.00, '2026-02-09 10:00:00', 4), 
(3, 'REC-002', 450.00, '2026-03-05 14:30:00', 2), 
(7, 'REC-004', 850.00, '2026-02-14 11:00:00', 4), 
(8, 'REC-005', 850.00, '2026-03-12 10:30:00', 4), 
(12, 'REC-006', 600.00, '2026-02-20 18:45:00', 3), 
(14, 'REC-007', 500.00, '2026-02-05 08:00:00', 5), 
(17, 'REC-008', 350.00, '2025-11-09 15:00:00', 4), 
(18, 'REC-009', 550.00, '2026-02-14 19:30:00', 2), 
(19, 'REC-010', 550.00, '2026-03-14 08:45:00', 2); 

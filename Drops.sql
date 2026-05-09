-- SCRIPT DE RESET ESTRUTURAL 

-- Desliga a verificacao para ignorar a ordem de exclusao
SET FOREIGN_KEY_CHECKS = 0;

-- Drop das Tabelas Analiticas 
DROP TABLE IF EXISTS fato_financeiro;
DROP TABLE IF EXISTS dim_tempo;
DROP TABLE IF EXISTS dim_aluno;
DROP TABLE IF EXISTS dim_curso;  
DROP TABLE IF EXISTS dim_unidade; 

-- Drop das Tabelas Operacionais 
DROP TABLE IF EXISTS pagamentos;
DROP TABLE IF EXISTS inadimplencia; 
DROP TABLE IF EXISTS mensalidades;
DROP TABLE IF EXISTS contrato_financeiro;
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS professores;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS pessoas;
DROP TABLE IF EXISTS enderecos;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS titulacoes;

-- Drop das Views 
DROP VIEW IF EXISTS vw_lista_alunos;
DROP VIEW IF EXISTS vw_lista_professores;
DROP VIEW IF EXISTS vw_alunos_adimplentes;
DROP VIEW IF EXISTS vw_resumo_financeiro;
DROP VIEW IF EXISTS vw_ocupacao_turmas;    
DROP VIEW IF EXISTS vw_alunos_devedores;   
DROP VIEW IF EXISTS vw_custo_funcionarios; 

-- Religa a verificacao para garantir a segurança da integridade relacional
SET FOREIGN_KEY_CHECKS = 1;

-- Mensagem de confirmacao para o console
SELECT 'Reset estrutural concluído com êxito. Entidades selecionadas foram removidas.' AS status;

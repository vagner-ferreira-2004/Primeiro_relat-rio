DROP DATABASE IF EXISTS sisgesc;
CREATE DATABASE IF NOT EXISTS sisgesc;
USE sisgesc;

-- CONFIGURACOES BASE E SALARIO MINIMO

CREATE TABLE salario_minimo (
    pk_salario_minimo INT AUTO_INCREMENT PRIMARY KEY,
    valor_salario_minimo DECIMAL(10,2) NOT NULL,
    data_vigencia_inicio DATE NOT NULL UNIQUE,
    data_vigencia_fim DATE,
    decreto_lei VARCHAR(100) COMMENT 'Numero do decreto ou lei',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE estados (
    pk_estado INT AUTO_INCREMENT PRIMARY KEY,
    sigla_estado CHAR(2) NOT NULL UNIQUE,
    nome_estado VARCHAR(50) NOT NULL UNIQUE,
    regiao ENUM('Norte', 'Nordeste', 'Centro-Oeste', 'Sudeste', 'Sul') NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- INFRAESTRUTURA E PESSOAS

CREATE TABLE enderecos (
    pk_endereco INT AUTO_INCREMENT PRIMARY KEY,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(150) NOT NULL,
    numero_endereco VARCHAR(10) NOT NULL,
    complemento_endereco VARCHAR(80) NOT NULL DEFAULT '',
    bairro_endereco VARCHAR(100),
    cidade_endereco VARCHAR(100) NOT NULL,
    pk_estado INT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_endereco_estado FOREIGN KEY (pk_estado)
        REFERENCES estados(pk_estado) ON DELETE RESTRICT,
    UNIQUE (cep, numero_endereco, complemento_endereco)
) ENGINE=InnoDB;

CREATE TABLE pessoas (
    pk_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    cpf_pessoa VARCHAR(14) NOT NULL UNIQUE,
    nome_pessoa VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    pk_endereco INT NOT NULL,
    genero_pessoa ENUM('Masculino', 'Feminino', 'Nao Binario', 'Nao Informar') NOT NULL DEFAULT 'Nao Informar',
    raca_pessoa ENUM('Branca', 'Preta', 'Parda', 'Amarela', 'Indigena', 'Nao Informar') NOT NULL DEFAULT 'Nao Informar',
    estado_civil ENUM('Solteiro', 'Casado', 'Divorciado', 'Viuvo', 'Uniao Estavel', 'Nao Informar') NOT NULL DEFAULT 'Nao Informar',
    nacionalidade VARCHAR(50) NOT NULL DEFAULT 'Brasileira',
    naturalidade VARCHAR(100),
    nome_mae VARCHAR(150),
    nome_pai VARCHAR(150),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_pessoa_endereco FOREIGN KEY (pk_endereco)
        REFERENCES enderecos(pk_endereco) ON DELETE RESTRICT,
    INDEX idx_pessoa_nome (nome_pessoa)
) ENGINE=InnoDB;

-- CONTATOS (TELEFONE E EMAIL SEPARADOS)

CREATE TABLE telefones (
    pk_telefone INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL,
    tipo_telefone ENUM('Celular', 'Fixo', 'Comercial', 'WhatsApp', 'Recado') NOT NULL,
    ddi VARCHAR(4) NOT NULL DEFAULT '+55',
    ddd VARCHAR(3) NOT NULL,
    numero_telefone VARCHAR(15) NOT NULL,
    is_principal BOOLEAN DEFAULT FALSE,
    recebe_sms BOOLEAN DEFAULT FALSE,
    recebe_whatsapp BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_telefone_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE,
    UNIQUE (pk_pessoa, ddd, numero_telefone)
) ENGINE=InnoDB;

CREATE TABLE emails (
    pk_email INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL,
    tipo_email ENUM('Pessoal', 'Institucional', 'Comercial', 'Academico') NOT NULL,
    endereco_email VARCHAR(150) NOT NULL UNIQUE,
    is_principal BOOLEAN DEFAULT FALSE,
    is_verificado BOOLEAN DEFAULT FALSE,
    data_verificacao DATETIME,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_email_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE contatos_emergencia (
    pk_contato_emergencia INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL,
    nome_contato VARCHAR(150) NOT NULL,
    parentesco ENUM('Pai', 'Mae', 'Irmao', 'Irma', 'Conjuge', 'Filho', 'Filha', 'Tio', 'Tia', 'Avo', 'Amigo', 'Outro') NOT NULL,
    telefone_contato VARCHAR(20) NOT NULL,
    email_contato VARCHAR(150),
    is_responsavel_financeiro BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_emergencia_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE
) ENGINE=InnoDB;

-- TIPOS DE DEFICIENCIA E ACESSIBILIDADE (PCD)

CREATE TABLE categorias_deficiencia (
    pk_categoria_def INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria ENUM(
        'Deficiencia Fisica', 
        'Deficiencia Visual', 
        'Deficiencia Auditiva', 
        'Deficiencia Intelectual', 
        'Deficiencia Multipla',
        'Transtorno Espectro Autista',
        'Altas Habilidades',
        'Transtorno de Aprendizagem'
    ) NOT NULL UNIQUE,
    descricao_categoria TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE tipos_deficiencia (
    pk_deficiencia INT AUTO_INCREMENT PRIMARY KEY,
    codigo_deficiencia VARCHAR(20) NOT NULL UNIQUE,
    nome_deficiencia VARCHAR(100) NOT NULL UNIQUE,
    pk_categoria_def INT NOT NULL,
    cid_codigo VARCHAR(10) COMMENT 'Codigo CID-10/CID-11',
    descricao_deficiencia TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_deficiencia_categoria FOREIGN KEY (pk_categoria_def)
        REFERENCES categorias_deficiencia(pk_categoria_def) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pessoa_deficiencia (
    pk_pessoa_deficiencia INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL,
    pk_deficiencia INT NOT NULL,
    grau_deficiencia ENUM('Leve', 'Moderado', 'Severo', 'Profundo') NOT NULL,
    necessita_acompanhante BOOLEAN DEFAULT FALSE,
    nome_acompanhante VARCHAR(150),
    telefone_acompanhante VARCHAR(20),
    data_diagnostico DATE,
    data_laudo DATE,
    numero_laudo VARCHAR(50),
    validade_laudo DATE,
    medico_responsavel VARCHAR(150),
    crm_medico VARCHAR(20),
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_pessoa_def_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE,
    CONSTRAINT fk_pessoa_def_tipo FOREIGN KEY (pk_deficiencia)
        REFERENCES tipos_deficiencia(pk_deficiencia) ON DELETE RESTRICT,
    UNIQUE (pk_pessoa, pk_deficiencia)
) ENGINE=InnoDB;

CREATE TABLE tipos_recurso_acessibilidade (
    pk_tipo_recurso INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo ENUM(
        'Recurso Fisico',
        'Recurso Tecnologico',
        'Recurso Pedagogico',
        'Recurso Comunicacao',
        'Recurso Mobiliario',
        'Recurso Humano'
    ) NOT NULL UNIQUE,
    descricao_tipo TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE recursos_acessibilidade (
    pk_recurso INT AUTO_INCREMENT PRIMARY KEY,
    nome_recurso VARCHAR(100) NOT NULL UNIQUE,
    pk_tipo_recurso INT NOT NULL,
    descricao_recurso TEXT,
    custo_estimado DECIMAL(10,2) COMMENT 'Custo para adquirir/implementar',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_recurso_tipo FOREIGN KEY (pk_tipo_recurso)
        REFERENCES tipos_recurso_acessibilidade(pk_tipo_recurso) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE pessoa_recurso_necessario (
    pk_pessoa_recurso INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL,
    pk_recurso INT NOT NULL,
    prioridade ENUM('Baixa', 'Media', 'Alta', 'Essencial') NOT NULL DEFAULT 'Media',
    ja_disponibilizado BOOLEAN DEFAULT FALSE,
    data_disponibilizacao DATE,
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_pessoa_recurso_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE,
    CONSTRAINT fk_pessoa_recurso_recurso FOREIGN KEY (pk_recurso)
        REFERENCES recursos_acessibilidade(pk_recurso) ON DELETE RESTRICT,
    UNIQUE (pk_pessoa, pk_recurso)
) ENGINE=InnoDB;

-- INFRAESTRUTURA FISICA - SALAS E ESPACOS

CREATE TABLE tipos_sala (
    pk_tipo_sala INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(50) NOT NULL UNIQUE,
    descricao_tipo VARCHAR(200),
    permite_aula BOOLEAN DEFAULT TRUE,
    permite_evento BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE blocos (
    pk_bloco INT AUTO_INCREMENT PRIMARY KEY,
    codigo_bloco VARCHAR(10) NOT NULL UNIQUE,
    nome_bloco VARCHAR(50) NOT NULL UNIQUE,
    descricao_bloco VARCHAR(200),
    quantidade_andares INT NOT NULL DEFAULT 1,
    possui_elevador BOOLEAN DEFAULT FALSE,
    possui_rampa BOOLEAN DEFAULT FALSE,
    possui_banheiro_acessivel BOOLEAN DEFAULT FALSE,
    possui_piso_tatil BOOLEAN DEFAULT FALSE,
    ano_construcao YEAR,
    area_total_m2 DECIMAL(10,2),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE salas (
    pk_sala INT AUTO_INCREMENT PRIMARY KEY,
    codigo_sala VARCHAR(20) NOT NULL UNIQUE,
    nome_sala VARCHAR(100) NOT NULL,
    pk_tipo_sala INT NOT NULL,
    pk_bloco INT NOT NULL,
    andar INT NOT NULL DEFAULT 0,
    capacidade_sala INT NOT NULL,
    capacidade_pcd INT NOT NULL DEFAULT 0 COMMENT 'Vagas especificas para PCD',
    area_metros DECIMAL(8,2),
    possui_ar_condicionado BOOLEAN DEFAULT FALSE,
    possui_projetor BOOLEAN DEFAULT FALSE,
    possui_computadores BOOLEAN DEFAULT FALSE,
    quantidade_computadores INT DEFAULT 0,
    possui_quadro_interativo BOOLEAN DEFAULT FALSE,
    possui_audio BOOLEAN DEFAULT FALSE,
    possui_webcam BOOLEAN DEFAULT FALSE,
    is_acessivel_cadeirante BOOLEAN DEFAULT FALSE,
    is_acessivel_visual BOOLEAN DEFAULT FALSE,
    is_acessivel_auditivo BOOLEAN DEFAULT FALSE,
    situacao_sala ENUM('Disponivel', 'Em Manutencao', 'Reservada', 'Indisponivel') NOT NULL DEFAULT 'Disponivel',
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_sala_tipo FOREIGN KEY (pk_tipo_sala)
        REFERENCES tipos_sala(pk_tipo_sala) ON DELETE RESTRICT,
    CONSTRAINT fk_sala_bloco FOREIGN KEY (pk_bloco)
        REFERENCES blocos(pk_bloco) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE sala_recurso_acessibilidade (
    pk_sala_recurso INT AUTO_INCREMENT PRIMARY KEY,
    pk_sala INT NOT NULL,
    pk_recurso INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    situacao ENUM('Funcionando', 'Em Manutencao', 'Defeito', 'Desativado') NOT NULL DEFAULT 'Funcionando',
    data_instalacao DATE,
    data_ultima_manutencao DATE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sala_recurso_sala FOREIGN KEY (pk_sala)
        REFERENCES salas(pk_sala) ON DELETE CASCADE,
    CONSTRAINT fk_sala_recurso_recurso FOREIGN KEY (pk_recurso)
        REFERENCES recursos_acessibilidade(pk_recurso) ON DELETE RESTRICT,
    UNIQUE (pk_sala, pk_recurso)
) ENGINE=InnoDB;

-- RECURSOS HUMANOS E CARGOS

CREATE TABLE departamentos (
    pk_departamento INT AUTO_INCREMENT PRIMARY KEY,
    codigo_departamento VARCHAR(20) NOT NULL UNIQUE,
    nome_departamento VARCHAR(100) NOT NULL UNIQUE,
    sigla_departamento VARCHAR(10),
    descricao_departamento TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE cargos (
    pk_cargo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_cargo VARCHAR(20) NOT NULL UNIQUE,
    nome_cargo VARCHAR(100) NOT NULL UNIQUE,
    pk_departamento INT,
    nivel_cargo ENUM('Operacional', 'Tecnico', 'Supervisao', 'Gerencial', 'Diretoria') NOT NULL DEFAULT 'Operacional',
    cbo_codigo VARCHAR(10) COMMENT 'Codigo CBO do cargo',
    descricao_cargo TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cargo_depto FOREIGN KEY (pk_departamento)
        REFERENCES departamentos(pk_departamento) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE titulacoes (
    pk_titulacao INT AUTO_INCREMENT PRIMARY KEY,
    nome_titulacao VARCHAR(60) NOT NULL UNIQUE,
    sigla_titulacao VARCHAR(10),
    nivel_titulacao INT NOT NULL DEFAULT 1 COMMENT '1=Graduado, 2=Especialista, 3=Mestre, 4=Doutor, 5=Pos-Doutor',
    percentual_adicional DECIMAL(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Percentual de adicional sobre salario base',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE faixas_salariais (
    pk_faixa INT AUTO_INCREMENT PRIMARY KEY,
    pk_cargo INT NOT NULL,
    pk_titulacao INT COMMENT 'Titulacao minima para a faixa',
    nivel_experiencia ENUM('Junior', 'Pleno', 'Senior', 'Especialista', 'Master') NOT NULL,
    quantidade_salarios_minimos DECIMAL(5,2) NOT NULL COMMENT 'Quantos salarios minimos',
    adicional_titulacao BOOLEAN DEFAULT TRUE COMMENT 'Se aplica adicional por titulacao',
    vigencia_inicio DATE NOT NULL,
    vigencia_fim DATE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_faixa_cargo FOREIGN KEY (pk_cargo)
        REFERENCES cargos(pk_cargo) ON DELETE CASCADE,
    CONSTRAINT fk_faixa_titulacao FOREIGN KEY (pk_titulacao)
        REFERENCES titulacoes(pk_titulacao) ON DELETE SET NULL,
    UNIQUE (pk_cargo, nivel_experiencia, vigencia_inicio)
) ENGINE=InnoDB;

CREATE TABLE areas_atuacao (
    pk_area_atuacao INT AUTO_INCREMENT PRIMARY KEY,
    codigo_area VARCHAR(20) NOT NULL UNIQUE,
    nome_area VARCHAR(100) NOT NULL UNIQUE COMMENT 'Ex: Inteligencia Artificial, Algoritmos',
    descricao_area TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE especialidades (
    pk_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    pk_area_atuacao INT NOT NULL,
    nome_especialidade VARCHAR(100) NOT NULL,
    descricao_especialidade TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_especialidade_area FOREIGN KEY (pk_area_atuacao)
        REFERENCES areas_atuacao(pk_area_atuacao) ON DELETE CASCADE,
    UNIQUE (pk_area_atuacao, nome_especialidade)
) ENGINE=InnoDB;

CREATE TABLE carga_horaria (
    pk_carga INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL UNIQUE,
    horas_semanais INT NOT NULL DEFAULT 0,
    horas_mensais INT NOT NULL DEFAULT 0,
    horas_totais INT NOT NULL,
    tipo_carga ENUM('Semanal', 'Mensal', 'Semestral', 'Anual') NOT NULL DEFAULT 'Semanal',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- FUNCIONARIOS E SALARIOS

CREATE TABLE funcionarios (
    matricula_rh INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL UNIQUE,
    pk_cargo INT NOT NULL,
    pk_faixa_salarial INT,
    pk_titulacao INT,
    pk_departamento INT,
    tipo_contrato ENUM('CLT', 'PJ', 'Estagiario', 'Temporario', 'Terceirizado') NOT NULL DEFAULT 'CLT',
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    situacao_funcionario ENUM('Ativo', 'Afastado', 'Desligado', 'Ferias', 'Licenca') NOT NULL DEFAULT 'Ativo',
    motivo_afastamento VARCHAR(200),
    pis_pasep VARCHAR(20),
    ctps_numero VARCHAR(20),
    ctps_serie VARCHAR(10),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_funcionario_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE,
    CONSTRAINT fk_funcionario_cargo FOREIGN KEY (pk_cargo)
        REFERENCES cargos(pk_cargo) ON DELETE RESTRICT,
    CONSTRAINT fk_funcionario_faixa FOREIGN KEY (pk_faixa_salarial)
        REFERENCES faixas_salariais(pk_faixa) ON DELETE SET NULL,
    CONSTRAINT fk_funcionario_titulacao FOREIGN KEY (pk_titulacao)
        REFERENCES titulacoes(pk_titulacao) ON DELETE SET NULL,
    CONSTRAINT fk_funcionario_depto FOREIGN KEY (pk_departamento)
        REFERENCES departamentos(pk_departamento) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE salarios_funcionarios (
    pk_salario INT AUTO_INCREMENT PRIMARY KEY,
    matricula_rh INT NOT NULL,
    pk_salario_minimo_ref INT NOT NULL COMMENT 'Salario minimo de referencia',
    quantidade_salarios_minimos DECIMAL(5,2) NOT NULL,
    salario_base DECIMAL(12,2) NOT NULL,
    adicional_titulacao DECIMAL(12,2) DEFAULT 0.00,
    adicional_tempo_servico DECIMAL(12,2) DEFAULT 0.00,
    adicional_insalubridade DECIMAL(12,2) DEFAULT 0.00,
    adicional_periculosidade DECIMAL(12,2) DEFAULT 0.00,
    adicional_noturno DECIMAL(12,2) DEFAULT 0.00,
    gratificacao DECIMAL(12,2) DEFAULT 0.00,
    vale_transporte DECIMAL(12,2) DEFAULT 0.00,
    vale_alimentacao DECIMAL(12,2) DEFAULT 0.00,
    plano_saude DECIMAL(12,2) DEFAULT 0.00,
    outros_beneficios DECIMAL(12,2) DEFAULT 0.00,
    salario_bruto DECIMAL(12,2) GENERATED ALWAYS AS (
        salario_base + adicional_titulacao + adicional_tempo_servico + 
        adicional_insalubridade + adicional_periculosidade + adicional_noturno + gratificacao
    ) STORED,
    custo_total_empresa DECIMAL(12,2) GENERATED ALWAYS AS (
        salario_base + adicional_titulacao + adicional_tempo_servico + 
        adicional_insalubridade + adicional_periculosidade + adicional_noturno + 
        gratificacao + vale_transporte + vale_alimentacao + plano_saude + outros_beneficios
    ) STORED,
    data_vigencia_inicio DATE NOT NULL,
    data_vigencia_fim DATE,
    motivo_alteracao VARCHAR(200),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_salario_funcionario FOREIGN KEY (matricula_rh)
        REFERENCES funcionarios(matricula_rh) ON DELETE CASCADE,
    CONSTRAINT fk_salario_minimo_ref FOREIGN KEY (pk_salario_minimo_ref)
        REFERENCES salario_minimo(pk_salario_minimo) ON DELETE RESTRICT,
    UNIQUE (matricula_rh, data_vigencia_inicio)
) ENGINE=InnoDB;

CREATE TABLE folha_pagamento (
    pk_folha INT AUTO_INCREMENT PRIMARY KEY,
    matricula_rh INT NOT NULL,
    mes_referencia TINYINT NOT NULL,
    ano_referencia SMALLINT NOT NULL,
    salario_bruto DECIMAL(12,2) NOT NULL,
    desconto_inss DECIMAL(12,2) DEFAULT 0.00,
    desconto_irrf DECIMAL(12,2) DEFAULT 0.00,
    desconto_vale_transporte DECIMAL(12,2) DEFAULT 0.00,
    desconto_plano_saude DECIMAL(12,2) DEFAULT 0.00,
    outros_descontos DECIMAL(12,2) DEFAULT 0.00,
    salario_liquido DECIMAL(12,2) GENERATED ALWAYS AS (
        salario_bruto - desconto_inss - desconto_irrf - desconto_vale_transporte - 
        desconto_plano_saude - outros_descontos
    ) STORED,
    data_pagamento DATE,
    situacao_pagamento ENUM('Pendente', 'Processando', 'Pago', 'Cancelado') NOT NULL DEFAULT 'Pendente',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_folha_funcionario FOREIGN KEY (matricula_rh)
        REFERENCES funcionarios(matricula_rh) ON DELETE CASCADE,
    UNIQUE (matricula_rh, mes_referencia, ano_referencia)
) ENGINE=InnoDB;

-- PROFESSORES E REMUNERACAO

CREATE TABLE professores (
    pk_docente INT AUTO_INCREMENT PRIMARY KEY,
    matricula_rh INT NOT NULL UNIQUE,
    pk_titulacao INT NOT NULL,
    pk_area_atuacao INT NOT NULL,
    regime_trabalho ENUM('Horista', 'Parcial 20h', 'Parcial 30h', 'Integral 40h', 'Dedicacao Exclusiva') NOT NULL,
    lattes_url VARCHAR(200),
    orcid VARCHAR(30),
    data_inicio_docencia DATE COMMENT 'Experiencia total como docente',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_professor_funcionario FOREIGN KEY (matricula_rh)
        REFERENCES funcionarios(matricula_rh) ON DELETE CASCADE,
    CONSTRAINT fk_professor_titulacao FOREIGN KEY (pk_titulacao)
        REFERENCES titulacoes(pk_titulacao) ON DELETE RESTRICT,
    CONSTRAINT fk_professor_area FOREIGN KEY (pk_area_atuacao)
        REFERENCES areas_atuacao(pk_area_atuacao) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE professor_especialidade (
    pk_prof_esp INT AUTO_INCREMENT PRIMARY KEY,
    pk_docente INT NOT NULL,
    pk_especialidade INT NOT NULL,
    nivel_conhecimento ENUM('Basico', 'Intermediario', 'Avancado', 'Especialista') NOT NULL DEFAULT 'Intermediario',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_prof_esp_docente FOREIGN KEY (pk_docente)
        REFERENCES professores(pk_docente) ON DELETE CASCADE,
    CONSTRAINT fk_prof_esp_especialidade FOREIGN KEY (pk_especialidade)
        REFERENCES especialidades(pk_especialidade) ON DELETE CASCADE,
    UNIQUE (pk_docente, pk_especialidade)
) ENGINE=InnoDB;

CREATE TABLE valor_hora_aula (
    pk_valor_hora INT AUTO_INCREMENT PRIMARY KEY,
    pk_titulacao INT NOT NULL,
    pk_salario_minimo_ref INT NOT NULL,
    percentual_salario_minimo DECIMAL(5,2) NOT NULL COMMENT 'Percentual do SM por hora',
    valor_hora DECIMAL(10,2) NOT NULL,
    vigencia_inicio DATE NOT NULL,
    vigencia_fim DATE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_valor_hora_titulacao FOREIGN KEY (pk_titulacao)
        REFERENCES titulacoes(pk_titulacao) ON DELETE CASCADE,
    CONSTRAINT fk_valor_hora_sm FOREIGN KEY (pk_salario_minimo_ref)
        REFERENCES salario_minimo(pk_salario_minimo) ON DELETE RESTRICT,
    UNIQUE (pk_titulacao, vigencia_inicio)
) ENGINE=InnoDB;

CREATE TABLE remuneracao_professores (
    pk_remuneracao INT AUTO_INCREMENT PRIMARY KEY,
    pk_docente INT NOT NULL,
    mes_referencia TINYINT NOT NULL,
    ano_referencia SMALLINT NOT NULL,
    quantidade_aulas INT NOT NULL DEFAULT 0,
    valor_hora_aula DECIMAL(10,2) NOT NULL,
    valor_aulas DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    adicional_orientacao DECIMAL(12,2) DEFAULT 0.00 COMMENT 'Orientacao de TCC/IC',
    adicional_coordenacao DECIMAL(12,2) DEFAULT 0.00,
    adicional_pesquisa DECIMAL(12,2) DEFAULT 0.00,
    adicional_extensao DECIMAL(12,2) DEFAULT 0.00,
    adicional_titulacao DECIMAL(12,2) DEFAULT 0.00,
    total_bruto DECIMAL(12,2) GENERATED ALWAYS AS (
        valor_aulas + adicional_orientacao + adicional_coordenacao + 
        adicional_pesquisa + adicional_extensao + adicional_titulacao
    ) STORED,
    data_pagamento DATE,
    situacao_pagamento ENUM('Pendente', 'Processando', 'Pago', 'Cancelado') NOT NULL DEFAULT 'Pendente',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_remuneracao_professor FOREIGN KEY (pk_docente)
        REFERENCES professores(pk_docente) ON DELETE CASCADE,
    UNIQUE (pk_docente, mes_referencia, ano_referencia)
) ENGINE=InnoDB;

-- CALENDARIO - DIAS, FERIADOS E EVENTOS

CREATE TABLE anos_letivos (
    pk_ano_letivo INT AUTO_INCREMENT PRIMARY KEY,
    ano INT NOT NULL UNIQUE,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    dias_letivos_previstos INT NOT NULL DEFAULT 200,
    situacao_ano ENUM('Planejado', 'Em Andamento', 'Encerrado') NOT NULL DEFAULT 'Planejado',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE semestres_letivos (
    pk_semestre INT AUTO_INCREMENT PRIMARY KEY,
    pk_ano_letivo INT NOT NULL,
    numero_semestre TINYINT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    data_inicio_matriculas DATE,
    data_fim_matriculas DATE,
    data_inicio_rematricula DATE,
    data_fim_rematricula DATE,
    situacao_semestre ENUM('Planejado', 'Matriculas Abertas', 'Em Andamento', 'Encerrado') NOT NULL DEFAULT 'Planejado',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_semestre_ano FOREIGN KEY (pk_ano_letivo)
        REFERENCES anos_letivos(pk_ano_letivo) ON DELETE CASCADE,
    UNIQUE (pk_ano_letivo, numero_semestre)
) ENGINE=InnoDB;

CREATE TABLE tipos_feriado (
    pk_tipo_feriado INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo ENUM(
        'Nacional',
        'Estadual',
        'Municipal',
        'Religioso',
        'Recesso Academico',
        'Ponto Facultativo',
        'Evento Institucional'
    ) NOT NULL UNIQUE,
    descricao_tipo VARCHAR(200),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE feriados (
    pk_feriado INT AUTO_INCREMENT PRIMARY KEY,
    pk_tipo_feriado INT NOT NULL,
    nome_feriado VARCHAR(100) NOT NULL,
    data_feriado DATE NOT NULL,
    recorrente BOOLEAN DEFAULT FALSE COMMENT 'Se repete todo ano na mesma data',
    pk_estado INT COMMENT 'Se estadual',
    cidade_abrangencia VARCHAR(100) COMMENT 'Se municipal',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_feriado_tipo FOREIGN KEY (pk_tipo_feriado)
        REFERENCES tipos_feriado(pk_tipo_feriado) ON DELETE RESTRICT,
    CONSTRAINT fk_feriado_estado FOREIGN KEY (pk_estado)
        REFERENCES estados(pk_estado) ON DELETE SET NULL,
    UNIQUE (data_feriado, pk_estado, cidade_abrangencia)
) ENGINE=InnoDB;

CREATE TABLE dias_letivos (
    pk_dia_letivo INT AUTO_INCREMENT PRIMARY KEY,
    pk_semestre INT NOT NULL,
    data_dia DATE NOT NULL,
    dia_semana ENUM('Domingo', 'Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado') NOT NULL,
    tipo_dia ENUM('Letivo', 'Feriado', 'Recesso', 'Sabado Letivo', 'Evento Academico', 'Avaliacao', 'Reposicao') NOT NULL DEFAULT 'Letivo',
    pk_feriado INT COMMENT 'Se for feriado, qual',
    observacao VARCHAR(200),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_dia_semestre FOREIGN KEY (pk_semestre)
        REFERENCES semestres_letivos(pk_semestre) ON DELETE CASCADE,
    CONSTRAINT fk_dia_feriado FOREIGN KEY (pk_feriado)
        REFERENCES feriados(pk_feriado) ON DELETE SET NULL,
    UNIQUE (pk_semestre, data_dia)
) ENGINE=InnoDB;

-- ACADEMICO - CURSOS E DISCIPLINAS

CREATE TABLE modalidades_ensino (
    pk_modalidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_modalidade ENUM('Presencial', 'EAD', 'Hibrido', 'Semi-Presencial') NOT NULL UNIQUE,
    descricao_modalidade TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE niveis_ensino (
    pk_nivel INT AUTO_INCREMENT PRIMARY KEY,
    nome_nivel ENUM('Tecnico', 'Graduacao', 'Pos-Graduacao Lato Sensu', 'Mestrado', 'Doutorado') NOT NULL UNIQUE,
    descricao_nivel TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE cursos (
    pk_curso INT AUTO_INCREMENT PRIMARY KEY,
    codigo_curso VARCHAR(20) NOT NULL UNIQUE,
    nome_curso VARCHAR(150) NOT NULL UNIQUE,
    pk_modalidade INT NOT NULL,
    pk_nivel INT NOT NULL,
    pk_area_atuacao INT NOT NULL,
    fk_carga_horaria INT NOT NULL,
    duracao_semestres INT NOT NULL DEFAULT 8,
    vagas_por_semestre INT NOT NULL DEFAULT 50,
    nota_mec DECIMAL(3,1) COMMENT 'Nota do MEC (0-5)',
    coordenador_pk_docente INT,
    descricao TEXT,
    situacao_curso ENUM('Ativo', 'Inativo', 'Em Extincao', 'Suspenso') NOT NULL DEFAULT 'Ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_curso_modalidade FOREIGN KEY (pk_modalidade)
        REFERENCES modalidades_ensino(pk_modalidade) ON DELETE RESTRICT,
    CONSTRAINT fk_curso_nivel FOREIGN KEY (pk_nivel)
        REFERENCES niveis_ensino(pk_nivel) ON DELETE RESTRICT,
    CONSTRAINT fk_curso_area FOREIGN KEY (pk_area_atuacao)
        REFERENCES areas_atuacao(pk_area_atuacao) ON DELETE RESTRICT,
    CONSTRAINT fk_curso_carga_ref FOREIGN KEY (fk_carga_horaria)
        REFERENCES carga_horaria(pk_carga) ON DELETE RESTRICT,
    CONSTRAINT fk_curso_coordenador FOREIGN KEY (coordenador_pk_docente)
        REFERENCES professores(pk_docente) ON DELETE SET NULL,
    INDEX idx_curso_situacao (situacao_curso)
) ENGINE=InnoDB;

CREATE TABLE disciplinas (
    pk_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    codigo_disciplina VARCHAR(20) NOT NULL UNIQUE,
    nome_disciplina VARCHAR(100) NOT NULL,
    fk_carga_horaria INT NOT NULL,
    pk_area_atuacao INT NOT NULL,
    pk_curso INT NOT NULL,
    semestre_recomendado TINYINT,
    tipo_disciplina ENUM('Obrigatoria', 'Optativa', 'Eletiva', 'TCC', 'Estagio') NOT NULL DEFAULT 'Obrigatoria',
    ementa TEXT,
    bibliografia_basica TEXT,
    bibliografia_complementar TEXT,
    situacao_disciplina ENUM('Ativa', 'Inativa', 'Em Extincao') NOT NULL DEFAULT 'Ativa',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_disciplina_curso FOREIGN KEY (pk_curso)
        REFERENCES cursos(pk_curso) ON DELETE CASCADE,
    CONSTRAINT fk_disciplina_carga_ref FOREIGN KEY (fk_carga_horaria)
        REFERENCES carga_horaria(pk_carga) ON DELETE RESTRICT,
    CONSTRAINT fk_disciplina_area FOREIGN KEY (pk_area_atuacao)
        REFERENCES areas_atuacao(pk_area_atuacao) ON DELETE RESTRICT,
    UNIQUE (nome_disciplina, pk_curso)
) ENGINE=InnoDB;

CREATE TABLE pre_requisitos (
    pk_pre_requisito INT AUTO_INCREMENT PRIMARY KEY,
    pk_disciplina INT NOT NULL,
    pk_disciplina_requisito INT NOT NULL,
    tipo_requisito ENUM('Obrigatorio', 'Recomendado', 'Co-Requisito') NOT NULL DEFAULT 'Obrigatorio',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_prereq_disciplina FOREIGN KEY (pk_disciplina)
        REFERENCES disciplinas(pk_disciplina) ON DELETE CASCADE,
    CONSTRAINT fk_prereq_requisito FOREIGN KEY (pk_disciplina_requisito)
        REFERENCES disciplinas(pk_disciplina) ON DELETE CASCADE,
    UNIQUE (pk_disciplina, pk_disciplina_requisito)
) ENGINE=InnoDB;

-- GESTAO DE ALUNOS

CREATE TABLE formas_ingresso (
    pk_forma_ingresso INT AUTO_INCREMENT PRIMARY KEY,
    nome_forma ENUM('SISU', 'PROUNI', 'FIES', 'Vestibular', 'ENEM', 'Transferencia Externa', 'Transferencia Interna', 'Reingresso', 'Convenio') NOT NULL UNIQUE,
    descricao_forma TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE tipos_cota (
    pk_tipo_cota INT AUTO_INCREMENT PRIMARY KEY,
    nome_cota ENUM('Ampla Concorrencia', 'Escola Publica', 'Escola Publica + Renda', 'Escola Publica + PPI', 'Escola Publica + Renda + PPI', 'PCD', 'Indigena', 'Quilombola') NOT NULL UNIQUE,
    descricao_cota TEXT,
    percentual_reserva DECIMAL(5,2) COMMENT 'Percentual de vagas reservadas',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE dados_ingresso (
    pk_ingresso INT AUTO_INCREMENT PRIMARY KEY,
    pk_forma_ingresso INT NOT NULL,
    pk_tipo_cota INT NOT NULL,
    pontuacao_enem DECIMAL(6,2),
    nota_redacao DECIMAL(6,2),
    pontuacao_vestibular DECIMAL(6,2),
    classificacao INT,
    ano_ingresso SMALLINT NOT NULL,
    semestre_ingresso TINYINT NOT NULL,
    edital_referencia VARCHAR(50),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ingresso_forma FOREIGN KEY (pk_forma_ingresso)
        REFERENCES formas_ingresso(pk_forma_ingresso) ON DELETE RESTRICT,
    CONSTRAINT fk_ingresso_cota FOREIGN KEY (pk_tipo_cota)
        REFERENCES tipos_cota(pk_tipo_cota) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE alunos (
    ra_aluno INT AUTO_INCREMENT PRIMARY KEY,
    pk_pessoa INT NOT NULL UNIQUE,
    pk_ingresso INT NOT NULL,
    pk_curso INT NOT NULL,
    data_matricula DATE NOT NULL,
    semestre_atual TINYINT NOT NULL DEFAULT 1,
    is_pcd BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'Se o aluno e PCD',
    necessita_atendimento_especial BOOLEAN DEFAULT FALSE,
    tipo_atendimento_especial TEXT COMMENT 'Descricao do atendimento necessario',
    situacao_aluno ENUM('Ativo', 'Trancado', 'Cancelado', 'Formado', 'Evadido', 'Jubilado', 'Transferido') NOT NULL DEFAULT 'Ativo',
    saldo_financeiro DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    coeficiente_rendimento DECIMAL(4,2) DEFAULT 0.00 COMMENT 'CR/IRA do aluno',
    data_previsao_formatura DATE,
    data_formatura DATE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_aluno_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE,
    CONSTRAINT fk_aluno_ingresso FOREIGN KEY (pk_ingresso)
        REFERENCES dados_ingresso(pk_ingresso) ON DELETE RESTRICT,
    CONSTRAINT fk_aluno_curso FOREIGN KEY (pk_curso)
        REFERENCES cursos(pk_curso) ON DELETE RESTRICT,
    INDEX idx_aluno_curso (pk_curso)
) AUTO_INCREMENT = 1000 ENGINE=InnoDB;

CREATE TABLE aluno_necessidade_especial (
    pk_aluno_necessidade INT AUTO_INCREMENT PRIMARY KEY,
    ra_aluno INT NOT NULL,
    pk_categoria_def INT NOT NULL,
    descricao_necessidade TEXT NOT NULL,
    recursos_necessarios TEXT,
    atendimento_prioritario BOOLEAN DEFAULT FALSE,
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_aluno_nec_aluno FOREIGN KEY (ra_aluno)
        REFERENCES alunos(ra_aluno) ON DELETE CASCADE,
    CONSTRAINT fk_aluno_nec_categoria FOREIGN KEY (pk_categoria_def)
        REFERENCES categorias_deficiencia(pk_categoria_def) ON DELETE RESTRICT,
    UNIQUE (ra_aluno, pk_categoria_def)
) ENGINE=InnoDB;

-- TURMAS E HORARIOS

CREATE TABLE turmas (
    pk_turma INT AUTO_INCREMENT PRIMARY KEY,
    codigo_turma VARCHAR(20) NOT NULL UNIQUE,
    pk_disciplina INT NOT NULL,
    pk_semestre INT NOT NULL,
    pk_docente INT NOT NULL,
    pk_sala INT NOT NULL,
    turno ENUM('Matutino', 'Vespertino', 'Noturno', 'Integral') NOT NULL,
    vagas_totais INT NOT NULL DEFAULT 40,
    vagas_disponiveis INT NOT NULL DEFAULT 40,
    vagas_pcd INT NOT NULL DEFAULT 2 COMMENT 'Vagas reservadas PCD',
    situacao_turma ENUM('Aberta', 'Fechada', 'Em Andamento', 'Encerrada', 'Cancelada') NOT NULL DEFAULT 'Aberta',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_turma_disciplina FOREIGN KEY (pk_disciplina)
        REFERENCES disciplinas(pk_disciplina) ON DELETE CASCADE,
    CONSTRAINT fk_turma_semestre FOREIGN KEY (pk_semestre)
        REFERENCES semestres_letivos(pk_semestre) ON DELETE RESTRICT,
    CONSTRAINT fk_turma_docente FOREIGN KEY (pk_docente)
        REFERENCES professores(pk_docente) ON DELETE RESTRICT,
    CONSTRAINT fk_turma_sala FOREIGN KEY (pk_sala)
        REFERENCES salas(pk_sala) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE horarios_turma (
    pk_horario_turma INT AUTO_INCREMENT PRIMARY KEY,
    pk_turma INT NOT NULL,
    dia_semana ENUM('Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_horario_turma FOREIGN KEY (pk_turma)
        REFERENCES turmas(pk_turma) ON DELETE CASCADE,
    UNIQUE (pk_turma, dia_semana, hora_inicio)
) ENGINE=InnoDB;

CREATE TABLE turma_compatibilidade_pcd (
    pk_compat INT AUTO_INCREMENT PRIMARY KEY,
    pk_turma INT NOT NULL,
    pk_categoria_def INT NOT NULL,
    is_compativel BOOLEAN NOT NULL DEFAULT FALSE,
    recursos_disponiveis TEXT,
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_compat_turma FOREIGN KEY (pk_turma)
        REFERENCES turmas(pk_turma) ON DELETE CASCADE,
    CONSTRAINT fk_compat_categoria FOREIGN KEY (pk_categoria_def)
        REFERENCES categorias_deficiencia(pk_categoria_def) ON DELETE RESTRICT,
    UNIQUE (pk_turma, pk_categoria_def)
) ENGINE=InnoDB;


-- INSCRICOES E MATRICULAS

CREATE TABLE inscricoes (
    pk_inscricao INT AUTO_INCREMENT PRIMARY KEY,
    ra_aluno INT NOT NULL,
    pk_turma INT NOT NULL,
    data_inscricao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    situacao_inscricao ENUM('Inscrito', 'Confirmado', 'Cancelado', 'Trancado', 'Aprovado', 'Reprovado', 'Reprovado Falta') NOT NULL DEFAULT 'Inscrito',
    nota_final DECIMAL(4,2),
    frequencia_percentual DECIMAL(5,2) DEFAULT 0.00,
    total_faltas INT DEFAULT 0,
    aprovado BOOLEAN,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_inscricao_aluno FOREIGN KEY (ra_aluno)
        REFERENCES alunos(ra_aluno) ON DELETE CASCADE,
    CONSTRAINT fk_inscricao_turma FOREIGN KEY (pk_turma)
        REFERENCES turmas(pk_turma) ON DELETE CASCADE,
    UNIQUE (ra_aluno, pk_turma)
) ENGINE=InnoDB;


-- AVALIACOES E NOTAS

CREATE TABLE tipos_avaliacao (
    pk_tipo_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo ENUM('Prova', 'Trabalho', 'Seminario', 'Projeto', 'Exercicio', 'Participacao', 'Prova Final', 'Recuperacao') NOT NULL UNIQUE,
    descricao_tipo TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE avaliacoes (
    pk_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    pk_turma INT NOT NULL,
    pk_tipo_avaliacao INT NOT NULL,
    titulo_avaliacao VARCHAR(100) NOT NULL,
    descricao_avaliacao TEXT,
    data_avaliacao DATE NOT NULL,
    data_entrega DATE,
    peso DECIMAL(3,2) NOT NULL DEFAULT 1.00 COMMENT 'Peso da avaliacao na media',
    nota_maxima DECIMAL(5,2) NOT NULL DEFAULT 10.00,
    is_recuperacao BOOLEAN DEFAULT FALSE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_avaliacao_turma FOREIGN KEY (pk_turma)
        REFERENCES turmas(pk_turma) ON DELETE CASCADE,
    CONSTRAINT fk_avaliacao_tipo FOREIGN KEY (pk_tipo_avaliacao)
        REFERENCES tipos_avaliacao(pk_tipo_avaliacao) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE notas (
    pk_nota INT AUTO_INCREMENT PRIMARY KEY,
    pk_avaliacao INT NOT NULL,
    pk_inscricao INT NOT NULL,
    nota_obtida DECIMAL(5,2),
    data_lancamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(200),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_nota_avaliacao FOREIGN KEY (pk_avaliacao)
        REFERENCES avaliacoes(pk_avaliacao) ON DELETE CASCADE,
    CONSTRAINT fk_nota_inscricao FOREIGN KEY (pk_inscricao)
        REFERENCES inscricoes(pk_inscricao) ON DELETE CASCADE,
    UNIQUE (pk_avaliacao, pk_inscricao)
) ENGINE=InnoDB;


-- MODULO 15: AULAS E PRESENCAS

CREATE TABLE aulas (
    pk_aula INT AUTO_INCREMENT PRIMARY KEY,
    pk_turma INT NOT NULL,
    pk_dia_letivo INT NOT NULL,
    numero_aula TINYINT NOT NULL DEFAULT 1 COMMENT 'Numero da aula no dia',
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    conteudo_ministrado TEXT,
    situacao_aula ENUM('Agendada', 'Realizada', 'Cancelada', 'Reposicao') NOT NULL DEFAULT 'Agendada',
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_aula_turma FOREIGN KEY (pk_turma)
        REFERENCES turmas(pk_turma) ON DELETE CASCADE,
    CONSTRAINT fk_aula_dia FOREIGN KEY (pk_dia_letivo)
        REFERENCES dias_letivos(pk_dia_letivo) ON DELETE RESTRICT,
    UNIQUE (pk_turma, pk_dia_letivo, numero_aula)
) ENGINE=InnoDB;

CREATE TABLE presencas (
    pk_presenca INT AUTO_INCREMENT PRIMARY KEY,
    pk_aula INT NOT NULL,
    pk_inscricao INT NOT NULL,
    presente BOOLEAN NOT NULL DEFAULT FALSE,
    justificativa TEXT,
    documento_justificativa VARCHAR(200) COMMENT 'Caminho do documento anexado',
    justificativa_aceita BOOLEAN,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_presenca_aula FOREIGN KEY (pk_aula)
        REFERENCES aulas(pk_aula) ON DELETE CASCADE,
    CONSTRAINT fk_presenca_inscricao FOREIGN KEY (pk_inscricao)
        REFERENCES inscricoes(pk_inscricao) ON DELETE CASCADE,
    UNIQUE (pk_aula, pk_inscricao)
) ENGINE=InnoDB;


-- FINANCEIRO - CONTRATOS E MENSALIDADES

CREATE TABLE planos_pagamento (
    pk_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome_plano VARCHAR(100) NOT NULL UNIQUE,
    quantidade_parcelas INT NOT NULL,
    percentual_desconto DECIMAL(5,2) DEFAULT 0.00,
    dia_vencimento INT NOT NULL DEFAULT 10,
    descricao TEXT,
    situacao_plano ENUM('Ativo', 'Inativo') NOT NULL DEFAULT 'Ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE contrato_financeiro (
    pk_contrato INT AUTO_INCREMENT PRIMARY KEY,
    ra_aluno INT NOT NULL,
    pk_plano INT NOT NULL,
    pk_semestre INT NOT NULL,
    valor_total_semestre DECIMAL(12,2) NOT NULL,
    percentual_bolsa DECIMAL(5,2) DEFAULT 0.00,
    valor_bolsa DECIMAL(12,2) DEFAULT 0.00,
    valor_final DECIMAL(12,2) NOT NULL,
    data_contrato DATE NOT NULL,
    situacao_contrato ENUM('Ativo', 'Quitado', 'Inadimplente', 'Cancelado', 'Renegociado') NOT NULL DEFAULT 'Ativo',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_contrato_aluno FOREIGN KEY (ra_aluno)
        REFERENCES alunos(ra_aluno) ON DELETE CASCADE,
    CONSTRAINT fk_contrato_plano FOREIGN KEY (pk_plano)
        REFERENCES planos_pagamento(pk_plano) ON DELETE RESTRICT,
    CONSTRAINT fk_contrato_semestre FOREIGN KEY (pk_semestre)
        REFERENCES semestres_letivos(pk_semestre) ON DELETE RESTRICT,
    UNIQUE (ra_aluno, pk_semestre)
) ENGINE=InnoDB;

CREATE TABLE mensalidades (
    pk_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    pk_contrato INT NOT NULL,
    numero_parcela TINYINT NOT NULL,
    valor_parcela DECIMAL(12,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    valor_pago DECIMAL(12,2) DEFAULT 0.00,
    data_pagamento DATE,
    valor_multa DECIMAL(12,2) DEFAULT 0.00,
    valor_juros DECIMAL(12,2) DEFAULT 0.00,
    valor_desconto DECIMAL(12,2) DEFAULT 0.00,
    situacao_mensalidade ENUM('Pendente', 'Paga', 'Atrasada', 'Cancelada', 'Renegociada') NOT NULL DEFAULT 'Pendente',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_mensalidade_contrato FOREIGN KEY (pk_contrato)
        REFERENCES contrato_financeiro(pk_contrato) ON DELETE CASCADE,
    UNIQUE (pk_contrato, numero_parcela)
) ENGINE=InnoDB;

CREATE TABLE formas_pagamento (
    pk_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_forma ENUM('Dinheiro', 'Cartao Credito', 'Cartao Debito', 'PIX', 'Boleto', 'Transferencia', 'Cheque') NOT NULL UNIQUE,
    taxa_operacao DECIMAL(5,2) DEFAULT 0.00,
    prazo_compensacao INT DEFAULT 0 COMMENT 'Dias para compensar',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE pagamentos (
    pk_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    pk_mensalidade INT NOT NULL,
    pk_forma_pagamento INT NOT NULL,
    valor_pago DECIMAL(12,2) NOT NULL,
    data_pagamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    numero_transacao VARCHAR(100),
    comprovante VARCHAR(200),
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_pagamento_mensalidade FOREIGN KEY (pk_mensalidade)
        REFERENCES mensalidades(pk_mensalidade) ON DELETE CASCADE,
    CONSTRAINT fk_pagamento_forma FOREIGN KEY (pk_forma_pagamento)
        REFERENCES formas_pagamento(pk_forma_pagamento) ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE inadimplencia (
    pk_inadimplencia INT AUTO_INCREMENT PRIMARY KEY,
    ra_aluno INT NOT NULL,
    pk_mensalidade INT NOT NULL,
    dias_atraso INT NOT NULL DEFAULT 0,
    valor_divida DECIMAL(12,2) NOT NULL,
    notificacao_enviada BOOLEAN DEFAULT FALSE,
    data_notificacao DATE,
    situacao_inadimplencia ENUM('Ativa', 'Negociando', 'Quitada', 'Juridico') NOT NULL DEFAULT 'Ativa',
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_inadimplencia_aluno FOREIGN KEY (ra_aluno)
        REFERENCES alunos(ra_aluno) ON DELETE CASCADE,
    CONSTRAINT fk_inadimplencia_mensalidade FOREIGN KEY (pk_mensalidade)
        REFERENCES mensalidades(pk_mensalidade) ON DELETE CASCADE,
    UNIQUE (pk_mensalidade)
) ENGINE=InnoDB;


-- BIBLIOTECA


CREATE TABLE categorias_acervo (
    pk_categoria_acervo INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria ENUM('Livro', 'Periodico', 'Revista', 'TCC', 'Dissertacao', 'Tese', 'DVD', 'CD', 'E-book', 'Artigo') NOT NULL UNIQUE,
    prazo_emprestimo_dias INT NOT NULL DEFAULT 14,
    quantidade_maxima_emprestimo INT NOT NULL DEFAULT 3,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE acervo_biblioteca (
    pk_acervo INT AUTO_INCREMENT PRIMARY KEY,
    codigo_acervo VARCHAR(30) NOT NULL UNIQUE,
    isbn VARCHAR(20) UNIQUE,
    titulo VARCHAR(200) NOT NULL,
    subtitulo VARCHAR(200),
    pk_categoria_acervo INT NOT NULL,
    autores VARCHAR(300) NOT NULL,
    editora VARCHAR(100),
    edicao VARCHAR(20),
    ano_publicacao YEAR,
    numero_paginas INT,
    idioma VARCHAR(30) DEFAULT 'Portugues',
    quantidade_exemplares INT NOT NULL DEFAULT 1,
    quantidade_disponivel INT NOT NULL DEFAULT 1,
    localizacao_fisica VARCHAR(50) COMMENT 'Prateleira/Estante',
    situacao_acervo ENUM('Disponivel', 'Indisponivel', 'Em Restauro', 'Descartado') NOT NULL DEFAULT 'Disponivel',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_acervo_categoria FOREIGN KEY (pk_categoria_acervo)
        REFERENCES categorias_acervo(pk_categoria_acervo) ON DELETE RESTRICT,
    INDEX idx_acervo_titulo (titulo)
) ENGINE=InnoDB;

CREATE TABLE emprestimos_biblioteca (
    pk_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    pk_acervo INT NOT NULL,
    pk_pessoa INT NOT NULL,
    data_emprestimo DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATETIME,
    renovacoes INT DEFAULT 0,
    situacao_emprestimo ENUM('Ativo', 'Devolvido', 'Atrasado', 'Extraviado') NOT NULL DEFAULT 'Ativo',
    multa DECIMAL(10,2) DEFAULT 0.00,
    observacoes TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_emprestimo_acervo FOREIGN KEY (pk_acervo)
        REFERENCES acervo_biblioteca(pk_acervo) ON DELETE RESTRICT,
    CONSTRAINT fk_emprestimo_pessoa FOREIGN KEY (pk_pessoa)
        REFERENCES pessoas(pk_pessoa) ON DELETE CASCADE
) ENGINE=InnoDB;


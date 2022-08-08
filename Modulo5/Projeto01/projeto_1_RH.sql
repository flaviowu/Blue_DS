CREATE SCHEMA IF NOT EXISTS 'projeto_rh' DEFAULT CHARACTER SET utf8 ;
USE 'projeto_rh' ;

-- Tabela 'projeto_rh'.'candidato'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'candidato' (
  'id_candidato' INT NOT NULL AUTO_INCREMENT,
  'data_cadastro' DATE NULL,
  'nome' VARCHAR(30) NULL,
  'sobrenome' VARCHAR(30) NULL,
  'data_nascimento' DATE NULL,
  'email' VARCHAR(45) NULL,
  'cpf' VARCHAR(11) NULL,
  'candidato_exp_id_candidato_exp' INT NOT NULL,
  'candidato_formacao_id_candidato_formacao' INT NOT NULL,
  PRIMARY KEY ('id_candidato', 'candidato_exp_id_candidato_exp', 'candidato_formacao_id_candidato_formacao'),
  UNIQUE INDEX 'id_candidatos_UNIQUE' ('id_candidato' ASC) VISIBLE,
  UNIQUE INDEX 'cpf_UNIQUE' ('cpf' ASC) VISIBLE)

-- Tabela 'projeto_rh'.'candidato_exp'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'candidato_exp' (
  'id_candidato_exp' INT NOT NULL,
  'data_inicio' DATE NOT NULL,
  'data_final' DATE NULL,
  'empresa' VARCHAR(50) NULL,
  'cargo' VARCHAR(30) NULL,
  'descricao' VARCHAR(300) NULL,
  'id_candidato' INT NOT NULL,
  PRIMARY KEY ('id_candidato_exp', 'id_candidato'),
  INDEX 'fk_candidato_exp_candidato1_idx' ('id_candidato' ASC) VISIBLE,
  CONSTRAINT 'fk_candidato_exp_candidato1'
    FOREIGN KEY ('id_candidato')
    REFERENCES 'projeto_rh'.'candidato' ('id_candidato')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

-- Tabela 'projeto_rh'.'vaga'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'vaga' (
  'id_vaga' INT NOT NULL,
  'data_abertura' DATE NULL,
  'setor' VARCHAR(20) NULL,
  'cargo' VARCHAR(20) NULL,
  'tecnologias' VARCHAR(100) NULL,
  'descricao' VARCHAR(1000) NULL,
  PRIMARY KEY ('id_vaga'))


-- Tabela 'projeto_rh'.'candidato_formacao'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'candidato_formacao' (
  'id_candidato_formacao' INT NOT NULL,
  'data_inicio' DATE NOT NULL,
  'data_final' DATE NULL,
  'instituicao' VARCHAR(50) NULL,
  'curso' VARCHAR(30) NULL,
  'tipo' VARCHAR(20) NULL,
  'id_candidato' INT NOT NULL,
  PRIMARY KEY ('id_candidato_formacao', 'id_candidato'),
  INDEX 'fk_candidato_formacao_candidato1_idx' ('id_candidato' ASC) VISIBLE,
  CONSTRAINT 'fk_candidato_formacao_candidato1'
    FOREIGN KEY ('id_candidato')
    REFERENCES 'projeto_rh'.'candidato' ('id_candidato')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

-- Tabela 'projeto_rh'.'historico_etapa'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'historico_etapa' (
  'idetapa' INT NOT NULL,
  'etapa_atual' VARCHAR(20) NOT NULL DEFAULT 'candidatura',
  'candidatura_data:' DATE NOT NULL,
  'candidatura' TINYINT NOT NULL DEFAULT 1,
  'entrevista_RH_data' DATE NULL,
  'entrevista_RH' TINYINT NOT NULL DEFAULT 0,
  'entrevista_gestor_data' DATE NULL,
  'entrevista_gestor' TINYINT NOT NULL DEFAULT 0,
  'proposta_data' DATE NULL,
  'proposta' TINYINT NOT NULL DEFAULT 0,
  'contratacao_data' DATE NULL,
  'contratacao' TINYINT NOT NULL DEFAULT 0,
  'eliminacao_data' DATE NULL,
  'eliminacao' TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY ('idetapa'))


-- Tabela 'projeto_rh'.'aplicacoes'

CREATE TABLE IF NOT EXISTS 'projeto_rh'.'aplicacoes' (
  'vaga_id_vaga' INT NOT NULL,
  'candidato_id_candidatos' INT NOT NULL,
  'data_candidatura' DATE NULL,
  'ativa' TINYINT NULL,
  'historico_etapa_idetapa' INT NOT NULL,
  PRIMARY KEY ('vaga_id_vaga', 'candidato_id_candidatos'),
  INDEX 'fk_vaga_has_candidato_candidato1_idx' ('candidato_id_candidatos' ASC) VISIBLE,
  INDEX 'fk_vaga_has_candidato_vaga1_idx' ('vaga_id_vaga' ASC) VISIBLE,
  INDEX 'fk_aplicacoes_historico_etapa1_idx' ('historico_etapa_idetapa' ASC) VISIBLE,
  CONSTRAINT 'fk_vaga_has_candidato_vaga1'
    FOREIGN KEY ('vaga_id_vaga')
    REFERENCES 'projeto_rh'.'vaga' ('id_vaga')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'fk_vaga_has_candidato_candidato1'
    FOREIGN KEY ('candidato_id_candidatos')
    REFERENCES 'projeto_rh'.'candidato' ('id_candidato')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'fk_aplicacoes_historico_etapa1'
    FOREIGN KEY ('historico_etapa_idetapa')
    REFERENCES 'projeto_rh'.'historico_etapa' ('idetapa')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)

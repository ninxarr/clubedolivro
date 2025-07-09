-- Criação do banco de dados do Clube do Livro
CREATE DATABASE ClubeDoLivro;

USE ClubeDoLivro;

-- 1. Tabela de usuários: armazena todos os membros do clube e dados pessoais
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único do usuário
    nome VARCHAR(100) NOT NULL,                     -- Nome completo do usuário
    email VARCHAR(150) UNIQUE NOT NULL,             -- Email único do usuário
    idade INT NOT NULL,                             -- Idade do usuário
    data_entrada DATE NOT NULL);                    -- Data de entrada no clube

-- 2. Tabela de livros: armazena os livros do acervo do clube e seu status de leitura
-- Cada livro pode ter três status: 'em andamento', 'lido' ou 'pendente'
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,         -- Identificador único do livro
    titulo VARCHAR(200) NOT NULL,                    -- Título do livro
    autor VARCHAR(150),                               -- Autor do livro
    ano_publicacao INT,                              -- Ano de publicação do livro
    genero VARCHAR(100) NOT NULL,                     -- Gênero literário do livro
    status ENUM('em andamento', 'lido', 'pendente')   -- Status de leitura do livro para o clube
        DEFAULT 'pendente');


-- 3. Tabela de encontros de leitura: cada encontro trata um único livro que foi lido e debatido
-- Cada livro só pode ser tratado em um encontro, garantindo que não haja duplicidade
CREATE TABLE encontros (
    id_encontro INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único do encontro
    data_encontro DATE NOT NULL,                     -- Data do encontro
    local VARCHAR(200) NOT NULL,                     -- Local do encontro
    id_livro INT NOT NULL,                           -- Livro tratado no encontro
    status_encontro ENUM('programado', 'realizado') NOT NULL DEFAULT 'programado',  -- Status do encontro
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_livro));                             -- Garante que cada livro só apareça em um encontro

-- 4. Tabela de leituras: registra quais livros foram lidos por quais usuários e quando 
-- Cada leitura pode estar associada a um encontro, caso o livro tenha sido lido em grupo
CREATE TABLE leituras (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único da leitura
    id_usuario INT NOT NULL,                         -- Referência ao usuário
    id_livro INT NOT NULL,                           -- Referência ao livro
    data_leitura DATE NOT NULL,                      -- Data em que o livro foi lido
    id_encontro INT,                                 -- Referência ao encontro
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    FOREIGN KEY (id_encontro) REFERENCES encontros(id_encontro));

-- 5. Tabela de avaliações: armazena as notas dadas pelos usuários aos livros lidos, com comentários opcionais
-- Cada usuário pode avaliar cada livro apenas uma vez, garantindo unicidade na avaliação
CREATE TABLE avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,     -- Identificador único da avaliação
    id_usuario INT NOT NULL,                         -- Referência ao usuário
    id_livro INT NOT NULL,                           -- Referência ao livro
    nota ENUM('1', '2', '3', '4', '5'),              -- Nota atribuída ao livro
    comentario TEXT,                                 -- Comentário opcional junto da avaliação
    data_avaliacao DATE NOT NULL,                    -- Data da avaliação
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_usuario, id_livro));                    -- Garante que cada usuário avalie cada livro apenas uma vez


-- 6. Tabela de sugestões: armazena sugestões de próximos livros a serem lidos, com quem indicou e a data da sugestão
CREATE TABLE sugestoes (
    id_sugestao INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único da sugestão
    id_usuario INT NOT NULL,                         -- Referência ao usuário que sugeriu
    id_livro INT NOT NULL,                           -- Referência ao livro sugerido
    data_sugestao DATE NOT NULL,                     -- Data da sugestão
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_usuario, id_livro));                    -- Garante que o mesmo usuário não sugira o mesmo livro mais de uma vez


-- 7. Tabela de associação entre encontros e usuários: registra a participação dos usuários nos encontros
CREATE TABLE participantes_encontro (
    id_encontro INT NOT NULL,                        -- Referência ao encontro
    id_usuario INT NOT NULL,                         -- Referência ao usuário participante
    PRIMARY KEY (id_encontro, id_usuario),           -- Chave primária composta
    FOREIGN KEY (id_encontro) REFERENCES encontros(id_encontro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario));


-----------Funções, Views e Procedures para o Clube do Livro

--- Escolhi apresentar as funções primeiro pois uma das 
--- funções criadas será usada dentro de uma view

-- FUNÇÕES: --

-- Função: media_avaliacao_livro
-- Objetivo: Calcular a média das notas de avaliação de um livro.
-- Tabela: avaliacoes
DELIMITER $$
CREATE FUNCTION media_avaliacao_livro(lid INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
  DECLARE media DECIMAL(3,2);
  SELECT AVG(CAST(nota AS DECIMAL)) INTO media FROM avaliacoes WHERE id_livro = lid;
  RETURN media;
END $$
DELIMITER ;


-- Função: livros_nao_avaliados_usuario
-- Objetivo: Retorna quantos livros lidos ainda não foram avaliados por um usuário
-- Tabelas: leituras, avaliacoes
DELIMITER $$
CREATE FUNCTION livros_nao_avaliados_usuario(uid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE pendentes INT;
    
    SELECT COUNT(DISTINCT l.id_livro) INTO pendentes
    FROM leituras l
    LEFT JOIN avaliacoes a ON l.id_livro = a.id_livro 
        AND l.id_usuario = a.id_usuario
    WHERE l.id_usuario = uid 
        AND a.id_avaliacao IS NULL;
        
    RETURN pendentes;
END $$
DELIMITER ;

-- VIEWS:

-- View: livros_com_encontros
-- Objetivo: Exibir todos os livros lidos, com data e local do encontro em que foram discutidos.
-- Tabelas: livros, encontros (usando a função media_avaliacao_livro para calcular a média das avaliações)
CREATE VIEW livros_com_encontros AS 
SELECT 
    livros.titulo, 
    livros.autor, 
    encontros.data_encontro, 
    encontros.local,
    media_avaliacao_livro(livros.id_livro)
FROM livros
JOIN encontros ON livros.id_livro = encontros.id_livro
WHERE livros.status = 'lido';

-- View: proximos_encontros
-- Objetivo: Exibir os próximos encontros programados, com detalhes do livro e número de participantes confirmados
-- Tabelas: encontros, livros, participantes_encontro
CREATE OR REPLACE VIEW proximos_encontros AS
SELECT 
    encontros.id_encontro,
    encontros.data_encontro,
    encontros.local,
    livros.titulo,
    COUNT(participantes_encontro.id_usuario) as participantes_confirmados
FROM encontros
JOIN livros ON encontros.id_livro = livros.id_livro
LEFT JOIN participantes_encontro ON encontros.id_encontro = participantes_encontro.id_encontro
WHERE encontros.status_encontro = 'programado' 
GROUP BY encontros.id_encontro, encontros.data_encontro, encontros.local, livros.titulo
ORDER BY encontros.data_encontro;

-- View: ranking_participacao
-- Objetivo: Mostrar ranking dos usuários mais participativos, incluindo número de encontros, 
-- avaliações feitas e sugestões dadas
CREATE VIEW ranking_participacao AS
SELECT 
    usuarios.nome,
    COUNT(DISTINCT participantes_encontro.id_encontro) as total_encontros,
    COUNT(DISTINCT avaliacoes.id_avaliacao) as total_avaliacoes,
    COUNT(DISTINCT sugestoes.id_sugestao) as total_sugestoes,
    (COUNT(DISTINCT participantes_encontro.id_encontro) + 
     COUNT(DISTINCT avaliacoes.id_avaliacao) + 
     COUNT(DISTINCT sugestoes.id_sugestao)) as pontuacao_total
FROM usuarios
LEFT JOIN participantes_encontro ON usuarios.id_usuario = participantes_encontro.id_usuario
LEFT JOIN avaliacoes ON usuarios.id_usuario = avaliacoes.id_usuario
LEFT JOIN sugestoes ON usuarios.id_usuario = sugestoes.id_usuario
GROUP BY usuarios.id_usuario, usuarios.nome
ORDER BY pontuacao_total DESC;


-- STORED PROCEDURES

-- Procedure: adiciona_sugestao
-- Objetivo: Adicionar uma nova sugestão de livro para um usuário, evitando duplicidade.
-- Tabela: sugestoes
DELIMITER $$
CREATE PROCEDURE adiciona_sugestao(
  IN p_id_usuario INT,
  IN p_id_livro INT,
  IN p_data_sugestao DATE
)
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM sugestoes WHERE id_usuario = p_id_usuario AND id_livro = p_id_livro
  ) THEN
    INSERT INTO sugestoes (id_usuario, id_livro, data_sugestao)
    VALUES (p_id_usuario, p_id_livro, p_data_sugestao);
  END IF;
END $$
DELIMITER ;


-- Procedure: estatisticas_usuario
-- Objetivo: Mostrar estatísticas completas de um usuário
DELIMITER $$
CREATE PROCEDURE estatisticas_usuario(IN p_id_usuario INT)
BEGIN
    SELECT 
        u.nome,
        COUNT(DISTINCT l.id_livro) as livros_lidos,
        COUNT(DISTINCT a.id_avaliacao) as avaliacoes_feitas,
        COUNT(DISTINCT pe.id_encontro) as encontros_participados,
        COUNT(DISTINCT s.id_sugestao) as sugestoes_feitas,
        ROUND(AVG(CAST(a.nota AS DECIMAL)), 1) as media_notas_dadas
    FROM usuarios u
    LEFT JOIN leituras l ON u.id_usuario = l.id_usuario
    LEFT JOIN avaliacoes a ON u.id_usuario = a.id_usuario
    LEFT JOIN participantes_encontro pe ON u.id_usuario = pe.id_usuario
    LEFT JOIN sugestoes s ON u.id_usuario = s.id_usuario
    WHERE u.id_usuario = p_id_usuario
    GROUP BY u.id_usuario, u.nome;
END $$
DELIMITER ;

-- TRIGGERS:

-- 1. Trigger para atualizar status do livro quando é criado um encontro
-- Só atualiza o status do livro quando o encontro for realizado

DELIMITER $$
DROP TRIGGER IF EXISTS trig_atualiza_status_livro $$
CREATE TRIGGER trig_atualiza_status_livro
AFTER UPDATE ON encontros
FOR EACH ROW
BEGIN
    IF NEW.status_encontro = 'realizado' THEN 
        UPDATE livros 
        SET status = 'lido'
        WHERE id_livro = NEW.id_livro;
    END IF;
END $$
DELIMITER ;

-- 2. Trigger para verificar número mínimo de participantes em um encontro
-- e notificar caso não atinja o mínimo de 3 participantes
DELIMITER $$

CREATE TRIGGER trig_verifica_participantes_minimos
AFTER INSERT ON participantes_encontro
FOR EACH ROW
BEGIN
    DECLARE total_participantes INT;

    -- Conta os participantes do mesmo encontro
    SELECT COUNT(*) INTO total_participantes
    FROM participantes_encontro
    WHERE id_encontro = NEW.id_encontro;

    -- Verifica se é um encontro programado e se tem menos de 3 participantes
    IF (
        (SELECT status_encontro 
         FROM encontros 
         WHERE id_encontro = NEW.id_encontro) = 'programado'
       ) AND total_participantes < 3 THEN
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'Atenção: Encontro precisa de pelo menos 3 participantes para ser realizado';
    END IF;
END$$

DELIMITER ;

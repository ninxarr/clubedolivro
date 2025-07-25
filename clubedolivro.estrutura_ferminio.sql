-- Criação do banco de dados do Clube do Livro
CREATE DATABASE clubedolivro;
USE clubedolivro;

-- Tabelas auxiliares (sem dependências)
-- Tabela de referência para cargos de usuário
CREATE TABLE cargos_usuario (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    cargo VARCHAR(50) NOT NULL
);

-- Tabelas de referência para autores, editoras, gêneros,
-- status de livro e encontros
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(150) NOT NULL
);

CREATE TABLE editoras (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome_editora VARCHAR(150) NOT NULL
);

CREATE TABLE generos (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    genero VARCHAR(100) NOT NULL
);

CREATE TABLE status_livro (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(30) NOT NULL
);

CREATE TABLE status_encontro (
    id_status_encontro INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(30) NOT NULL
);

-- Tabelas principais (dependem das anteriores)
-- Tabela de usuários, atribuindo nome, email, idade, data de entrada no clube, e cargo
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    idade INT NOT NULL,
    data_entrada DATE NOT NULL,
    id_cargo INT,
    FOREIGN KEY (id_cargo) REFERENCES cargos_usuario(id_cargo)
);

-- Tabela de livros, atribuindo titulo, ano de publicação, 
-- e relacionando autor, gênero, editora e status
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT,
    ano_publicacao INT,
    id_genero INT,
    id_editora INT,
    id_status INT,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
    FOREIGN KEY (id_editora) REFERENCES editoras(id_editora),
    FOREIGN KEY (id_status) REFERENCES status_livro(id_status)
);

-- Tabela de subgrupos, criando subgrupos dentro do clube, podendo variar em genero de leitura, faixa etaria, e etc.
-- relacionando criador, gênero e atribuindo uma descrição
CREATE TABLE subgrupos (
    id_subgrupo INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    id_criador INT NOT NULL,
    id_genero INT NOT NULL,
    descricao TEXT,
    FOREIGN KEY (id_criador) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

-- Tabela de encontros, registrando os encontros do clube, relacionando livro, subgrupo e status
-- atribuindo data, local e formato do encontro
CREATE TABLE encontros (
    id_encontro INT AUTO_INCREMENT PRIMARY KEY,
    data_encontro DATE NOT NULL,
    local VARCHAR(200) NOT NULL,
    id_livro INT NOT NULL,
    formato_encontro ENUM('presencial', 'virtual', 'oficina', 'palestra') DEFAULT 'presencial',
    id_status_encontro INT NOT NULL,
    id_subgrupo INT,
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    FOREIGN KEY (id_status_encontro) REFERENCES status_encontro(id_status_encontro),
    FOREIGN KEY (id_subgrupo) REFERENCES subgrupos(id_subgrupo),
    UNIQUE (id_livro)
);

-- Tabela de leituras, registrando as leituras feitas pelos usuários, relacionando usuário, livro e encontro
-- atribuindo data de leitura
CREATE TABLE leituras (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_leitura DATE NOT NULL,
    id_encontro INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    FOREIGN KEY (id_encontro) REFERENCES encontros(id_encontro)
);

-- Tabela de avaliações, registrando as avaliações dos livros pelos usuários,
-- relacionando usuário, livro e atribuindo nota, comentário e data de avaliação
CREATE TABLE avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    nota ENUM('1', '2', '3', '4', '5'),
    comentario TEXT,
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_usuario, id_livro)
);

-- Tabela de sugestões, registrando sugestões de livros feitas pelos usuários,
-- relacionando usuário, livro e atribuindo data de sugestão
CREATE TABLE sugestoes (
    id_sugestao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_sugestao DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_usuario, id_livro)
);

-- Tabelas de relacionamento
-- Tabela de participantes de encontros, registrando quais usuários participaram de quais encontros
CREATE TABLE participantes_encontro (
    id_encontro INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_encontro, id_usuario),
    FOREIGN KEY (id_encontro) REFERENCES encontros(id_encontro),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
-- Tabela de usuários em subgrupos, registrando quais usuários pertencem a quais subgrupos
CREATE TABLE usuario_subgrupo (
    id_usuario INT NOT NULL,
    id_subgrupo INT NOT NULL,
    PRIMARY KEY (id_usuario, id_subgrupo),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_subgrupo) REFERENCES subgrupos(id_subgrupo)
);

-- FUNÇÕES
-- Calculam métricas específicas para o Clube do Livro, como médias, totais e pendências.

-- Calcula a média das avaliações de um livro
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

-- Retorna a quantidade de livros lidos por um usuário que ainda não foram avaliados
DELIMITER $$
CREATE FUNCTION livros_nao_avaliados_usuario(uid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE pendentes INT;
    SELECT COUNT(DISTINCT l.id_livro) INTO pendentes
    FROM leituras l
    LEFT JOIN avaliacoes a ON l.id_livro = a.id_livro AND l.id_usuario = a.id_usuario
    WHERE l.id_usuario = uid AND a.id_avaliacao IS NULL;
    RETURN pendentes;
END $$
DELIMITER ;

-- Retorna o total de encontros que um usuário participou
DELIMITER $$
CREATE FUNCTION total_encontros_participados(uid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_encontro) INTO total
    FROM participantes_encontro
    WHERE id_usuario = uid;
    RETURN total;
END $$
DELIMITER ;

-- Retorna o total de sugestões feitas por um usuário
DELIMITER $$
CREATE FUNCTION total_sugestoes_usuario(uid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM sugestoes
    WHERE id_usuario = uid;
    RETURN total;
END $$
DELIMITER ;

-- VIEWS

-- Esta view lista os livros lidos, seus autores, a data e local do encontro, e a média de avaliação dos livros.
CREATE VIEW livros_com_encontros AS 
SELECT 
    livros.titulo, 
    autores.nome_autor,
    encontros.data_encontro, 
    encontros.local,
    media_avaliacao_livro(livros.id_livro) AS media_avaliacao
FROM livros
JOIN autores ON livros.id_autor = autores.id_autor
JOIN encontros ON livros.id_livro = encontros.id_livro
WHERE livros.id_status = (SELECT id_status FROM status_livro WHERE status = 'lido');

-- Esta view mostra os encontros programados, incluindo o livro discutido, local, data e número de participantes confirmados.
CREATE VIEW proximos_encontros AS
SELECT 
    encontros.id_encontro,
    encontros.data_encontro,
    encontros.local,
    livros.titulo,
    COUNT(participantes_encontro.id_usuario) as participantes_confirmados
FROM encontros
JOIN livros ON encontros.id_livro = livros.id_livro
LEFT JOIN participantes_encontro ON encontros.id_encontro = participantes_encontro.id_encontro
WHERE encontros.id_status_encontro = (SELECT id_status_encontro FROM status_encontro WHERE status = 'programado')
GROUP BY encontros.id_encontro, encontros.data_encontro, encontros.local, livros.titulo
ORDER BY encontros.data_encontro;

-- Esta view calcula a pontuação total de cada usuário com base em encontros participados, avaliações feitas e sugestões enviadas.
CREATE VIEW ranking_participacao AS
SELECT 
    usuarios.nome,
    total_encontros_participados(usuarios.id_usuario) as total_encontros,
    COUNT(DISTINCT avaliacoes.id_avaliacao) as total_avaliacoes,
    total_sugestoes_usuario(usuarios.id_usuario) as total_sugestoes,
    (total_encontros_participados(usuarios.id_usuario) + 
     COUNT(DISTINCT avaliacoes.id_avaliacao) + 
     total_sugestoes_usuario(usuarios.id_usuario)) as pontuacao_total
FROM usuarios
LEFT JOIN avaliacoes ON usuarios.id_usuario = avaliacoes.id_usuario
GROUP BY usuarios.id_usuario, usuarios.nome
ORDER BY pontuacao_total DESC;

-- Esta view lista os livros lidos por usuários que ainda não fizeram avaliações,
-- incluindo o título do livro, nome do usuário e data de leitura.
CREATE VIEW livros_sem_avaliacao AS
SELECT l.id_livro, l.titulo, u.nome
FROM leituras le
JOIN livros l ON le.id_livro = l.id_livro
JOIN usuarios u ON le.id_usuario = u.id_usuario
LEFT JOIN avaliacoes a ON le.id_livro = a.id_livro AND le.id_usuario = a.id_usuario
WHERE a.id_avaliacao IS NULL;

-- Estatísticas de leitura e avaliação dos livros por gênero
CREATE VIEW estatisticas_livros AS
SELECT 
    l.titulo,
    g.genero,
    COUNT(le.id_leitura) as total_leituras,
    AVG(CAST(a.nota AS DECIMAL)) as media_avaliacao
FROM livros l
JOIN generos g ON l.id_genero = g.id_genero
LEFT JOIN leituras le ON l.id_livro = le.id_livro
LEFT JOIN avaliacoes a ON l.id_livro = a.id_livro
GROUP BY l.id_livro, l.titulo, g.genero;

-- Lista participantes de cada subgrupo
CREATE VIEW participantes_subgrupo AS
SELECT
    sg.titulo AS subgrupo,
    u.nome AS participante
FROM usuario_subgrupo us
JOIN usuarios u ON us.id_usuario = u.id_usuario
JOIN subgrupos sg ON us.id_subgrupo = sg.id_subgrupo;

-- Mostra detalhes completos dos encontros, incluindo livro, autor, editora, subgrupo e criador
CREATE VIEW encontros_detalhados AS
SELECT
    e.id_encontro,
    e.data_encontro,
    e.local,
    l.titulo AS livro,
    a.nome_autor AS autor,
    g.genero,
    ed.nome_editora AS editora,
    e.formato_encontro,
    se.status AS status_encontro,
    sg.titulo AS subgrupo,
    u.nome AS criador_subgrupo
FROM encontros e
JOIN livros l ON e.id_livro = l.id_livro
JOIN autores a ON l.id_autor = a.id_autor
JOIN generos g ON l.id_genero = g.id_genero
JOIN editoras ed ON l.id_editora = ed.id_editora
JOIN status_encontro se ON e.id_status_encontro = se.id_status_encontro
JOIN subgrupos sg ON e.id_subgrupo = sg.id_subgrupo
JOIN usuarios u ON sg.id_criador = u.id_usuario;

-- STORED PROCEDURES

-- Adiciona uma sugestão de livro para um usuário, evitando duplicidade
-- Esta procedure recebe o ID do usuário, ID do livro e a data da sugestão.
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

-- Gera estatísticas completas de participação de um usuário
-- Esta procedure recebe o ID do usuário e retorna o nome, total de livros lidos,
-- total de avaliações feitas, encontros participados, sugestões feitas e média de notas dadas.
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

-- Cria ranking de participação por subgrupo
-- Esta procedure recebe o ID do subgrupo e retorna o ranking de usuários
-- com base no número de encontros participados, ordenado do maior para o menor.
DELIMITER $$
CREATE PROCEDURE ranking_subgrupo(IN p_id_subgrupo INT)
BEGIN
    SELECT
        u.nome,
        COUNT(DISTINCT pe.id_encontro) AS encontros_participados
    FROM usuario_subgrupo us
    JOIN usuarios u ON us.id_usuario = u.id_usuario
    LEFT JOIN participantes_encontro pe ON u.id_usuario = pe.id_usuario
    LEFT JOIN encontros e ON pe.id_encontro = e.id_encontro
    WHERE us.id_subgrupo = p_id_subgrupo
      AND e.id_subgrupo = p_id_subgrupo
    GROUP BY u.id_usuario, u.nome
    ORDER BY encontros_participados DESC;
END $$
DELIMITER ;

-- TRIGGERS

-- Atualiza o status do livro para "lido" quando o encontro é marcado como "realizado"
DELIMITER $$
CREATE TRIGGER trig_atualiza_status_livro
AFTER UPDATE ON encontros
FOR EACH ROW
BEGIN
    IF NEW.id_status_encontro = (SELECT id_status_encontro FROM status_encontro WHERE status = 'realizado') THEN 
        UPDATE livros 
        SET id_status = (SELECT id_status FROM status_livro WHERE status = 'lido')
        WHERE id_livro = NEW.id_livro;
    END IF;
END $$
DELIMITER ;

-- Alerta se um encontro programado tem menos de 3 participantes
-- Esta trigger é acionada após a inserção de um participante em um encontro.
DELIMITER $$
CREATE TRIGGER trig_verifica_participantes_minimos
AFTER INSERT ON participantes_encontro
FOR EACH ROW
BEGIN
    DECLARE total_participantes INT;
    DECLARE status_atual VARCHAR(30);

    SELECT status INTO status_atual
    FROM status_encontro se
    JOIN encontros e ON se.id_status_encontro = e.id_status_encontro
    WHERE e.id_encontro = NEW.id_encontro;

    SELECT COUNT(*) INTO total_participantes
    FROM participantes_encontro
    WHERE id_encontro = NEW.id_encontro;

    IF status_atual = 'programado' AND total_participantes < 3 THEN
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'Atenção: Encontro precisa de pelo menos 3 participantes para ser realizado';
    END IF;
END $$
DELIMITER ;
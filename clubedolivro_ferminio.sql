-- Criação do banco de dados
CREATE DATABASE ClubeDoLivro;
USE ClubeDoLivro;

-- Tabela de usuários
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    idade INT NOT NULL,
    data_entrada DATE NOT NULL);

-- Tabela de livros
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor VARCHAR(150),
    ano_publicacao INT,
    genero VARCHAR(100) NOT NULL,
    status ENUM('em andamento', 'lido', 'pendente') DEFAULT 'pendente');

-- Tabela de leituras (registro de livros lidos por usuário com data)
CREATE TABLE leituras (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_leitura DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro));

-- Tabela de avaliações de leituras feitas por usuários
CREATE TABLE avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    nota ENUM('1', '2', '3', '4', '5'),
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro),
    UNIQUE (id_usuario, id_livro));

-- Inserindo dados: 

-- Cargos dos usuários
INSERT INTO cargos_usuario (cargo) VALUES
('Presidente Grupo'), ('Moderador'), ('Membro'), ('Convidado');

-- Gêneros literários
INSERT INTO generos (genero) VALUES
('Terror'), ('Ficção Científica'), ('Fantasia'), ('Romance'), ('Mistério');

-- Status dos livros
INSERT INTO status_livro (status) VALUES
('lido'), ('em andamento'), ('pendente');

-- Status dos encontros
INSERT INTO status_encontro (status) VALUES
('programado'), ('realizado');

-- Autores
INSERT INTO autores (nome_autor) VALUES
('Stephen King'), ('George Orwell'), ('J.K. Rowling'), ('Machado de Assis'), ('Agatha Christie'),
('Clarice Lispector'), ('Isaac Asimov'), ('Suzanne Collins'), ('J.R.R. Tolkien'), ('Gabriel García Márquez'),
('Haruki Murakami'), ('Neil Gaiman'), ('Margaret Atwood'), ('Colleen Hoover'), ('Dan Brown'),
('Jane Austen'), ('Victor Hugo'), ('George R.R. Martin'), ('Lygia Fagundes Telles'), ('Jojo Moyes');

-- Editoras
INSERT INTO editoras (nome_editora) VALUES
('Companhia das Letras'), ('Rocco'), ('Intrínseca'), ('HarperCollins'), ('Record'),
('Editora Globo'), ('Sextante'), ('Planeta'), ('Alfaguara'), ('Nova Fronteira'),
('Penguin Books'), ('DarkSide Books'), ('Editora Arqueiro'), ('Editora Objetiva'), ('Editora Saraiva');

-- Usuários (com os criadores dos subgrupos já como 'Presidente Grupo')
INSERT INTO usuarios (nome, email, idade, data_entrada, id_cargo) VALUES
('Ana Silva', 'ana@clubelivro.com', 29, '2024-01-10', 1),
('Bruno Costa', 'bruno@clubelivro.com', 34, '2024-02-15', 1),
('Carla Souza', 'carla@clubelivro.com', 22, '2024-03-20', 1),
('Daniel Lima', 'daniel@clubelivro.com', 27, '2024-04-05', 3),
('Eduarda Torres', 'eduarda@clubelivro.com', 31, '2024-05-12', 4),
('Felipe Martins', 'felipe@clubelivro.com', 19, '2024-06-01', 3),
('Gisele Ramos', 'gisele@clubelivro.com', 41, '2024-06-15', 2),
('Hugo Almeida', 'hugo@clubelivro.com', 25, '2024-07-01', 3),
('Isabela Nunes', 'isabela@clubelivro.com', 37, '2024-07-10', 3),
('Juliana Prado', 'juliana@clubelivro.com', 28, '2024-07-20', 3),
('Kleber Souza', 'kleber@clubelivro.com', 33, '2024-08-01', 4),
('Larissa Melo', 'larissa@clubelivro.com', 24, '2024-08-10', 3),
('Marcos Vinicius', 'marcos@clubelivro.com', 45, '2024-08-15', 2),
('Natália Castro', 'natalia@clubelivro.com', 21, '2024-08-20', 3),
('Otávio Pires', 'otavio@clubelivro.com', 39, '2024-08-25', 3);

-- Subgrupos temáticos
INSERT INTO subgrupos (titulo, id_criador, id_genero, descricao) VALUES
('Ficção Científica Jovem', 1, 2, 'Grupo para fãs de ficção científica juvenil'),
('Clássicos Brasileiros', 2, 4, 'Leitura de obras clássicas nacionais'),
('Mistério para Adultos', 3, 5, 'Grupo dedicado a livros de mistério para adultos');

-- Livros
INSERT INTO livros (titulo, id_autor, ano_publicacao, id_genero, id_editora, id_status) VALUES
('O Iluminado', 1, 1977, 1, 1, 1),
('1984', 2, 1949, 2, 2, 1),
('Harry Potter e a Pedra Filosofal', 3, 1997, 3, 3, 2),
('Dom Casmurro', 4, 1899, 4, 4, 1),
('Assassinato no Expresso Oriente', 5, 1934, 5, 5, 3),
('A Hora da Estrela', 6, 1977, 4, 6, 1),
('Fundação', 7, 1951, 2, 7, 1),
('Jogos Vorazes', 8, 2008, 2, 8, 2),
('O Senhor dos Anéis', 9, 1954, 3, 9, 1),
('Cem Anos de Solidão', 10, 1967, 4, 10, 1),
('Kafka à Beira-Mar', 11, 2002, 4, 11, 2),
('Deuses Americanos', 12, 2001, 3, 12, 1),
('O Conto da Aia', 13, 1985, 2, 13, 1),
('É Assim Que Acaba', 14, 2016, 4, 14, 2),
('O Código Da Vinci', 15, 2003, 5, 15, 1),
('Orgulho e Preconceito', 16, 1813, 4, 1, 1),
('Os Miseráveis', 17, 1862, 4, 2, 1),
('A Guerra dos Tronos', 18, 1996, 3, 3, 2),
('As Meninas', 19, 1973, 4, 4, 1),
('Como Eu Era Antes de Você', 20, 2012, 4, 5, 2);

-- Encontros
INSERT INTO encontros (data_encontro, local, id_livro, formato_encontro, id_status_encontro, id_subgrupo) VALUES
('2025-01-10', 'Biblioteca Central', 1, 'presencial', 2, 1),
('2025-02-15', 'Café Literário', 2, 'presencial', 2, 1),
('2025-03-20', 'Sala Virtual Zoom', 3, 'virtual', 2, 2),
('2025-04-25', 'Auditório Municipal', 4, 'palestra', 2, 2),
('2025-05-30', 'Livraria Cultura', 5, 'presencial', 2, 3),
('2025-06-10', 'Sala de Estudos', 6, 'presencial', 2, 2),
('2025-07-20', 'Café do Centro', 7, 'presencial', 1, 1),
('2025-08-05', 'Sala Virtual Zoom', 8, 'virtual', 1, 1),
('2025-08-15', 'Biblioteca Central', 9, 'presencial', 1, 2),
('2025-08-25', 'Auditório Municipal', 10, 'palestra', 1, 3),
('2025-09-05', 'Livraria Cultura', 11, 'presencial', 1, 2),
('2025-09-15', 'Sala de Estudos', 12, 'presencial', 1, 1),
('2025-09-25', 'Café do Centro', 13, 'presencial', 1, 3),
('2025-10-05', 'Sala Virtual Zoom', 14, 'virtual', 1, 2),
('2025-10-15', 'Biblioteca Central', 15, 'presencial', 1, 1),
('2025-10-25', 'Auditório Municipal', 16, 'palestra', 1, 2),
('2025-11-05', 'Livraria Cultura', 17, 'presencial', 1, 3),
('2025-11-15', 'Sala de Estudos', 18, 'presencial', 1, 1),
('2025-11-25', 'Café do Centro', 19, 'presencial', 1, 2),
('2025-12-05', 'Sala Virtual Zoom', 20, 'virtual', 1, 3);

-- Leituras
INSERT INTO leituras (id_usuario, id_livro, data_leitura, id_encontro) VALUES
(1, 1, '2025-01-05', 1), (2, 1, '2025-01-06', 1), (3, 2, '2025-02-10', 2), (4, 2, '2025-02-12', 2),
(5, 3, '2025-03-15', 3), (6, 4, '2025-04-20', 4), (7, 5, '2025-05-25', 5), (8, 6, '2025-06-05', 6),
(9, 7, '2025-07-15', 7), (10, 8, '2025-08-01', 8), (11, 9, '2025-08-10', 9), (12, 10, '2025-08-20', 10),
(13, 11, '2025-09-01', 11), (14, 12, '2025-09-10', 12), (15, 13, '2025-09-20', 13), (1, 14, '2025-10-01', 14),
(2, 15, '2025-10-10', 15), (3, 16, '2025-10-20', 16), (4, 17, '2025-11-01', 17), (5, 18, '2025-11-10', 18),
(6, 19, '2025-11-20', 19), (7, 20, '2025-12-01', 20), (8, 1, '2025-01-07', 1), (9, 2, '2025-02-13', 2),
(10, 3, '2025-03-16', 3), (11, 4, '2025-04-21', 4), (12, 5, '2025-05-26', 5), (13, 6, '2025-06-06', 6),
(14, 7, '2025-07-16', 7), (15, 8, '2025-08-02', 8);

-- Avaliações
INSERT INTO avaliacoes (id_usuario, id_livro, nota, comentario, data_avaliacao) VALUES
(1, 1, '5', 'Excelente livro!', '2025-01-11'), (2, 1, '4', 'Muito bom!', '2025-01-12'),
(3, 2, '5', 'Obra-prima!', '2025-02-16'), (4, 2, '3', 'Interessante, mas difícil.', '2025-02-17'),
(5, 3, '4', 'Gostei bastante.', '2025-03-17'), (6, 4, '5', 'Clássico nacional!', '2025-04-22'),
(7, 5, '3', 'Bom mistério.', '2025-05-27'), (8, 6, '4', 'Emocionante!', '2025-06-07'),
(9, 7, '5', 'Fantástico!', '2025-07-17'), (10, 8, '4', 'Muito envolvente.', '2025-08-03'),
(11, 9, '5', 'Obra épica.', '2025-08-11'), (12, 10, '4', 'Muito interessante.', '2025-08-21'),
(13, 11, '5', 'Surpreendente.', '2025-09-02'), (14, 12, '4', 'Bem criativo.', '2025-09-12'),
(15, 13, '3', 'Diferente.', '2025-09-22'), (1, 14, '5', 'Muito bom!', '2025-10-02'),
(2, 15, '4', 'Prende a atenção.', '2025-10-11'), (3, 16, '5', 'Clássico!', '2025-10-21'),
(4, 17, '4', 'Muito longo, mas ótimo.', '2025-11-02'), (5, 18, '5', 'Adorei!', '2025-11-11'),
(6, 19, '4', 'Bem escrito.', '2025-11-21'), (7, 20, '5', 'Emocionante.', '2025-12-02');

-- Sugestões
INSERT INTO sugestoes (id_usuario, id_livro, data_sugestao) VALUES
(1, 3, '2025-03-01'), (2, 4, '2025-04-01'), (3, 5, '2025-05-01'), (4, 6, '2025-06-01'),
(5, 7, '2025-07-01'), (6, 8, '2025-08-01'), (7, 9, '2025-08-10'), (8, 10, '2025-08-20'),
(9, 11, '2025-09-01'), (10, 12, '2025-09-10'), (11, 13, '2025-09-20'), (12, 14, '2025-10-01'),
(13, 15, '2025-10-10'), (14, 16, '2025-10-20'), (15, 17, '2025-11-01'), (1, 18, '2025-11-10'),
(2, 19, '2025-11-20'), (3, 20, '2025-12-01');

-- Usuários em subgrupos
INSERT INTO usuario_subgrupo (id_usuario, id_subgrupo) VALUES
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 1), (7, 2), (8, 3), (9, 1), (10, 2),
(11, 3), (12, 1), (13, 2), (14, 3), (15, 1);

-- Participantes em encontros (exemplo, pode expandir conforme desejar)
INSERT INTO participantes_encontro (id_encontro, id_usuario) VALUES
(1, 1), (1, 2), (1, 3), (1, 6), (1, 9),
(2, 3), (2, 4), (2, 5), (2, 7), (2, 10),
(3, 5), (3, 8), (3, 11), (3, 14), (3, 2),
(4, 6), (4, 12), (4, 13), (4, 1), (4, 4),
(5, 7), (5, 8), (5, 9), (5, 15), (5, 5),
(6, 10), (6, 11), (6, 12), (6, 13), (6, 6),
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5),
(8, 8), (8, 9), (8, 10), (8, 11), (8, 12),
(9, 13), (9, 14), (9, 15), (9, 1), (9, 2),
(10, 3), (10, 4), (10, 5), (10, 6), (10, 7);

-- Execução das Views e Stored Procedures para testar e visualizar os resultados.

-- Execução das Views:
SELECT * FROM livros_com_encontros;
SELECT * FROM proximos_encontros;
SELECT * FROM ranking_participacao;
SELECT * FROM livros_sem_avaliacao;
SELECT * FROM estatisticas_livros;
SELECT * FROM participantes_subgrupo;
SELECT * FROM encontros_detalhados;

-- Execução das Stored Procedures:
-- Estatísticas de um usuário (exemplo para o usuário de id 1)
CALL estatisticas_usuario(1);

-- Ranking de participação em um subgrupo (exemplo para o subgrupo de id 1)
CALL ranking_subgrupo(1);

-- Adiciona sugestão de livro (exemplo para usuário 1 e livro 2)
CALL adiciona_sugestao(1, 2, '2025-07-01');

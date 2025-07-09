  -- Inserção de usuários
INSERT INTO usuarios (nome, email, idade, data_entrada) VALUES
('Ana Silva', 'ana.silva@email.com', 28, '2023-01-10'),
('Bruno Souza', 'bruno.souza@email.com', 35, '2023-02-15'),
('Carla Lima', 'carla.lima@email.com', 22, '2023-03-20'),
('Diego Martins', 'diego.martins@email.com', 31, '2023-04-05'),
('Elisa Torres', 'elisa.torres@email.com', 27, '2023-05-12'),
('Fábio Ramos', 'fabio.ramos@email.com', 40, '2023-06-18'),
('Gabriela Nunes', 'gabriela.nunes@email.com', 24, '2023-07-01'),
('Henrique Alves', 'henrique.alves@email.com', 29, '2023-07-15'),
('Isabela Costa', 'isabela.costa@email.com', 33, '2023-08-02'),
('João Pedro', 'joao.pedro@email.com', 26, '2023-08-20'),
('Laura Mendes', 'laura.mendes@email.com', 30, '2023-09-01'),
('Pedro Henrique', 'pedro.henrique@email.com', 25, '2023-09-15'),
('Marina Lopes', 'marina.lopes@email.com', 32, '2023-10-01');

-- Inserção de livros (lidos, em andamento e pendentes)
INSERT INTO livros (titulo, autor, ano_publicacao, genero, status) VALUES
('O Iluminado', 'Stephen King', 1977, 'Terror', 'lido'),                
('Garota Exemplar', 'Gillian Flynn', 2012, 'Suspense', 'lido'),         
('Drácula', 'Bram Stoker', 1897, 'Terror', 'lido'),                     
('O Código Da Vinci', 'Dan Brown', 2003, 'Suspense', 'lido'),           
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 'Fábula', 'lido'), 
('Sherlock Holmes: O Cão dos Baskervilles', 'Arthur Conan Doyle', 1902, 'Policial', 'lido'), 
('A Menina que Roubava Livros', 'Markus Zusak', 2005, 'Drama', 'lido'), 
('O Morro dos Ventos Uivantes', 'Emily Brontë', 1847, 'Romance', 'lido'), 
('O Silêncio dos Inocentes', 'Thomas Harris', 1988, 'Suspense', 'lido'), 
('Carrie, a Estranha', 'Stephen King', 1974, 'Terror', 'lido'),         
('It: A Coisa', 'Stephen King', 1986, 'Terror', 'em andamento'),        
('Orgulho e Preconceito', 'Jane Austen', 1813, 'Romance', 'em andamento'), 
('A Guerra dos Tronos', 'George R. R. Martin', 1996, 'Fantasia', 'pendente'),
('O Senhor dos Anéis: A Sociedade do Anel', 'J.R.R. Tolkien', 1954, 'Fantasia', 'pendente'),
('O Hobbit', 'J.R.R. Tolkien', 1937, 'Fantasia', 'pendente'),          
('A Culpa é das Estrelas', 'John Green', 2012, 'Romance', 'pendente'),  
('O Nome da Rosa', 'Umberto Eco', 1980, 'Suspense', 'pendente'),
('Ensaio Sobre a Cegueira', 'José Saramago', 1995, 'Drama', 'pendente'),
('O Alienista', 'Machado de Assis', 1882, 'Policial', 'pendente'),
('O Alquimista', 'Paulo Coelho', 1988, 'Ficção', 'em andamento'),
('A Biblioteca da Meia-Noite', 'Matt Haig', 2020, 'Ficção', 'pendente'),
('Torto Arado', 'Itamar Vieira Junior', 2019, 'Drama', 'pendente'),
('Pequenos Incêndios por Toda Parte', 'Celeste Ng', 2017, 'Drama', 'pendente'),
('O Conto da Aia', 'Margaret Atwood', 1985, 'Distopia', 'pendente'),
('A Paciente Silenciosa', 'Alex Michaelides', 2019, 'Suspense', 'pendente');

-- Inserção de encontros (apenas para livros lidos)
INSERT INTO encontros (data_encontro, local, id_livro, status_encontro) VALUES
('2023-04-05', 'Livraria Cultura - Shopping Bourbon Country', 1, 'realizado'),  
('2023-05-10', 'Biblioteca Pública do Estado', 2, 'realizado'),                 
('2023-06-15', 'Parque da Redenção', 3, 'realizado'),                          
('2023-07-20', 'Casa de Cultura Mario Quintana', 4, 'realizado'),              
('2023-08-18', 'Café do Porto', 5, 'realizado'),                               
('2023-09-22', 'Livraria Saraiva - Shopping Praia de Belas', 6, 'realizado'), 
('2023-10-10', 'Centro Cultural CEEE Erico Verissimo', 7, 'realizado'),        
('2023-11-12', 'Museu de Arte do Rio Grande do Sul', 8, 'realizado'),          
('2023-12-05', 'PUCRS Biblioteca Central', 9, 'realizado'),                    
('2024-01-15', 'Parque Germânia', 10, 'realizado'),
('2024-04-20', 'Solar dos Câmara', 11, 'programado'),                         
('2024-05-15', 'Jardim Botânico', 12, 'programado'),                        
('2024-06-10', 'Parque Moinhos de Vento', 20, 'programado'),                  
('2024-07-05', 'Teatro São Pedro', 13, 'programado'),                         
('2024-08-01', 'Fundação Iberê Camargo', 21, 'programado');      

-- Inserção de leituras (apenas para livros lidos e encontros existentes)
INSERT INTO leituras (id_usuario, id_livro, data_leitura, id_encontro) VALUES
(1, 1, '2023-04-01', 1),
(2, 1, '2023-04-02', 1),
(3, 2, '2023-05-05', 2),
(4, 3, '2023-06-10', 3),
(5, 4, '2023-07-15', 4),
(6, 5, '2023-08-10', 5),
(7, 6, '2023-09-20', 6),
(8, 7, '2023-10-05', 7),
(9, 8, '2023-11-10', 8),
(10, 9, '2023-12-01', 9),
(1, 10, '2024-01-10', 10),
(11, 1, '2024-02-18', 11),
(12, 2, '2024-03-10', 12),
(13, 3, '2024-03-12', 3);

-- Inserção de avaliações (apenas para livros lidos)
INSERT INTO avaliacoes (id_usuario, id_livro, nota, comentario, data_avaliacao) VALUES
(1, 1, '5', 'Assustador e envolvente!', '2023-04-06'),
(2, 1, '4', 'Muito bom, recomendo.', '2023-04-07'),
(3, 2, '5', 'Suspense do início ao fim.', '2023-05-11'),
(4, 3, '4', 'Terror clássico, adorei.', '2023-06-16'),
(5, 4, '4', 'Dan Brown nunca decepciona.', '2023-07-21'),
(6, 5, '5', 'Uma fábula encantadora.', '2023-08-19'),
(7, 6, '4', 'Sherlock é genial.', '2023-09-23'),
(8, 7, '5', 'Drama emocionante.', '2023-10-11'),
(9, 8, '4', 'Romance sombrio.', '2023-11-13'),
(10, 9, '5', 'Suspense psicológico incrível.', '2023-12-06'),
(1, 10, '4', 'Terror clássico do King.', '2024-01-16'),
(2, 3, '5', 'Drácula é um clássico do terror, adorei!', '2023-06-17'),
(3, 4, '4', 'Trama envolvente, leitura rápida.', '2023-07-22'),
(4, 5, '5', 'Uma história encantadora e cheia de lições.', '2023-08-20'),
(5, 6, '3', 'Esperava mais do mistério, mas gostei.', '2023-09-24'),
(6, 7, '4', 'Muito emocionante, recomendo.', '2023-10-12'),
(7, 8, '5', 'Romance intenso, personagens marcantes.', '2023-11-14'),
(8, 9, '4', 'Suspense muito bem construído.', '2023-12-07'),
(9, 10, '3', 'Achei o final previsível, mas gostei.', '2024-01-17'),
(10, 1, '5', 'Stephen King é genial, leitura eletrizante.', '2023-04-08'),
(1, 2, '4', 'Gostei do ritmo e das reviravoltas.', '2023-05-12'),
(2, 4, '5', 'Dan Brown sempre surpreende.', '2023-07-23'),
(3, 5, '3', 'Achei a linguagem simples, mas bonito.', '2023-08-21'),
(4, 6, '4', 'Sherlock é sempre uma boa escolha.', '2023-09-25'),
(5, 7, '5', 'Chorei muito, história tocante.', '2023-10-13'),
(6, 8, '4', 'Gostei do clima sombrio.', '2023-11-15'),
(7, 9, '5', 'Muito suspense, prendeu minha atenção.', '2023-12-08'),
(8, 10, '4', 'Terror psicológico muito bom.', '2024-01-18'),
(9, 1, '5', 'Um dos melhores livros que já li.', '2023-04-09'),
(10, 2, '3', 'Achei um pouco confuso, mas interessante.', '2023-05-13'),
(11, 1, '4', 'Gostei bastante da narrativa.', '2024-02-21'),
(12, 2, '5', 'Suspense excelente!', '2024-03-16'),
(13, 3, '4', 'Terror clássico, recomendo.', '2024-03-17');

-- Inserção de sugestões (livros lidos, em andamento e pendentes)
INSERT INTO sugestoes (id_usuario, id_livro, data_sugestao) VALUES
(1, 11, '2023-06-01'),
(2, 12, '2023-07-02'),
(3, 13, '2023-08-03'),
(4, 14, '2023-09-04'),
(5, 15, '2023-10-05'),
(6, 16, '2023-11-06'),
(7, 17, '2023-12-07'),
(8, 1, '2024-01-08'),
(9, 2, '2024-02-09'),
(10, 3, '2024-03-10'),
(11, 18, '2024-02-22'),
(12, 19, '2024-03-17'),
(13, 20, '2024-03-18'), 
(1, 21, '2024-04-01'),
(2, 22, '2024-04-02'),
(3, 23, '2024-04-03'),
(4, 24, '2024-04-04'),
(5, 25, '2024-04-05');

-- Inserção de participantes nos encontros (apenas para encontros existentes)
INSERT INTO participantes_encontro (id_encontro, id_usuario) VALUES
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 2), (2, 3), (2, 4), (2, 5),
(3, 3), (3, 4), (3, 5), (3, 6),
(4, 4), (4, 5), (4, 6), (4, 7),
(5, 5), (5, 6), (5, 7), (5, 8),
(6, 6), (6, 7), (6, 8), (6, 9),
(7, 7), (7, 8), (7, 9), (7, 10),
(8, 8), (8, 9), (8, 10), (8, 1),
(9, 9), (9, 10), (9, 1), (9, 2),
(10, 10), (10, 1), (10, 2), (10, 3),
(11, 1), (11, 2), (11, 3),  
(12, 4), (12, 5), (12, 6), 
(13, 7), (13, 8), (13, 9),  
(14, 10), (14, 1), (14, 2), 
(15, 3), (15, 4), (15, 5);

-- 1. Testando Views
-- livros_com_encontros:
SELECT * FROM livros_com_encontros;

--proximos_encontros:
SELECT * FROM proximos_encontros;

--ranking_participacao:
SELECT * FROM ranking_participacao;

-- 2. Testando Functions
--media_avaliacao_livro
SELECT titulo, media_avaliacao_livro(id_livro) as media_avaliacoes
FROM livros
WHERE status = 'lido'
ORDER BY media_avaliacoes DESC;

--livros_nao_avaliados_usuario
SELECT u.nome, livros_nao_avaliados_usuario(u.id_usuario) as livros_sem_avaliacao
FROM usuarios u
ORDER BY livros_sem_avaliacao DESC;

-- 3. Testando Procedures
-- adiciona_sugestao
CALL adiciona_sugestao(1, 15, CURDATE());
SELECT * FROM sugestoes WHERE id_usuario = 1 AND id_livro = 15;

--estatisticas_usuario
CALL estatisticas_usuario(5);

-- 4. Testando Triggers

---  1. trig_atualiza_status_livro:

SELECT id_livro, status FROM livros WHERE id_livro = 11;      --a) Verificar status antes
SELECT id_encontro, status_encontro FROM encontros WHERE id_livro = 11;

UPDATE encontros --b) Atualizar encontro para realizado
SET status_encontro = 'realizado' 
WHERE id_livro = 11;

SELECT id_livro, status FROM livros WHERE id_livro = 11;    --c) Verificar mudanças
SELECT id_encontro, status_encontro FROM encontros WHERE id_livro = 11;


---2. trig_verifica_participantes_minimos

-
INSERT INTO encontros (data_encontro, local, id_livro, status_encontro) -- Criar novo encontro para teste
VALUES ('2024-09-01', 'Biblioteca Municipal', 22, 'programado');


INSERT INTO participantes_encontro (id_encontro, id_usuario) -- Tentar adicionar menos de 3 participantes (deve gerar aviso)
VALUES 
((SELECT MAX(id_encontro) FROM encontros), 1),
((SELECT MAX(id_encontro) FROM encontros), 2);


SELECT e.id_encontro, e.data_encontro, COUNT(pe.id_usuario) as total_participantes -- Verificar participantes
FROM encontros e
LEFT JOIN participantes_encontro pe ON e.id_encontro = pe.id_encontro
WHERE e.id_encontro = (SELECT MAX(id_encontro) FROM encontros)
GROUP BY e.id_encontro, e.data_encontro;


SELECT titulo, status,  -- 5. Consultas de Verificação Final
       (SELECT COUNT(*) FROM avaliacoes a WHERE a.id_livro = l.id_livro) as total_avaliacoes
FROM livros l
ORDER BY status, total_avaliacoes DESC;

SELECT e.data_encontro, e.local, l.titulo, 
       COUNT(pe.id_usuario) as participantes,
       e.status_encontro
FROM encontros e
JOIN livros l ON e.id_livro = l.id_livro
LEFT JOIN participantes_encontro pe ON e.id_encontro = pe.id_encontro
GROUP BY e.id_encontro, e.data_encontro, e.local, l.titulo, e.status_encontro
ORDER BY e.data_encontro;

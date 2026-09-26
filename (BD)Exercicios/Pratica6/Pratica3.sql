CREATE DATABASE lista6;
USE lista6;

-- Parte 1: Criar as Tabelas com Constraints
CREATE TABLE animal(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    especie VARCHAR(45),
    raca VARCHAR(45),
    idade INT
);

CREATE TABLE ficha_medica(
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_ultima_consulta DATE,
    peso DECIMAL(10,2),
    vacina_em_dia VARCHAR(3) CHECK (vacina_em_dia IN ('sim', 'nao')),
    observacao VARCHAR(10000),
    fk_animal INT UNIQUE,
    CONSTRAINT fkAniFicha FOREIGN KEY(fk_animal) REFERENCES animal(id)
);

-- Parte 2: Inserir Dados de Exemplo
INSERT INTO animal (nome, especie, raca, idade) VALUES
('thor', 'cão', 'bulldog', 3),
('luna', 'gato', 'persa', 2),
('rex', 'cão', 'pastor alemão', 5),
('mimi', 'gato', 'siamês', 1),
('bob', 'cão', 'poodle', 4);

INSERT INTO ficha_medica (data_ultima_consulta, peso, vacina_em_dia, observacao, fk_animal) VALUES
('2026-01-10', 12.50, 'sim', 'check-up de rotina sem alterações.', 1),
('2026-02-15', 4.20, 'sim', 'vacinas aplicadas com sucesso.', 2),
('2026-03-01', 28.00, 'nao', 'pendente vacina da raiva.', 3),
('2026-03-20', 3.80, 'sim', 'tratamento de desparasitação concluído.', 4);

SELECT * FROM animal;
SELECT * FROM ficha_medica;

-- Teste de erro de duplicidade
INSERT INTO ficha_medica (data_ultima_consulta, peso, vacina_em_dia, observacao, fk_animal) VALUES
('2026-04-05', 13.00, 'sim', 'consulta de retorno para o mesmo animal.', 1);

-- Parte 3: Consultas com SELECT
SELECT nome, especie FROM animal;
SELECT * FROM ficha_medica WHERE vacina_em_dia = 'nao';
SELECT * FROM animal ORDER BY idade DESC;
SELECT * FROM animal WHERE especie = 'cão';

-- Parte 4: Consultas com AS (Renomear Colunas)
SELECT nome AS Pet, especie AS Tipo FROM animal;
SELECT peso AS 'Peso (kg)', data_ultima_consulta AS 'Ultima Consulta' FROM ficha_medica;
SELECT idade, (idade * 7) AS 'Idade Humana Aproximada' FROM animal;
SELECT nome AS 'Nome do Pet', raca AS 'Raca/Tipo' FROM animal;

-- Parte 5: Consultas com CASE
SELECT nome AS Nome,
    CASE
        WHEN idade < 2 THEN 'Filhote'
        WHEN idade >= 2 AND idade <= 7 THEN 'Adulto'
        ELSE 'Idoso'
    END AS fase_vida
FROM animal;
    
SELECT nome AS Nome,
    CASE
        WHEN vacina_em_dia = 'sim' THEN 'Vacinado'
        ELSE 'Pendente'
    END AS vacinacao
FROM animal JOIN ficha_medica ON animal.id = ficha_medica.fk_animal;
    
SELECT
    CASE
        WHEN peso < 5 THEN 'Pequeno'
        WHEN peso >= 5 AND peso < 20 THEN 'Médio'
        ELSE 'Grande'
    END AS porte
FROM ficha_medica;
    
SELECT nome,
    CASE
        WHEN especie = 'cão' THEN 'Canino'
        WHEN especie = 'gato' THEN 'Felino'
        ELSE 'Outro'
    END AS especie_tipo
FROM animal;

-- Parte 6: Consultas com IFNULL e JOIN
SELECT nome AS Nome, 
    IFNULL(observacao, 'Nenhuma observacao') AS 'Observação'
FROM animal JOIN ficha_medica ON animal.id = ficha_medica.fk_animal;

SELECT animal.*, IFNULL(data_ultima_consulta, 'SEM FICHA') AS Ficha
FROM animal LEFT JOIN ficha_medica ON animal.id = ficha_medica.fk_animal;

SELECT nome, peso, data_ultima_consulta 
FROM animal INNER JOIN ficha_medica ON animal.id = ficha_medica.fk_animal;

SELECT CONCAT(nome, ' - ', especie, ' - ', peso, 'kg') AS resumo
FROM animal INNER JOIN ficha_medica ON animal.id = ficha_medica.fk_animal;

SELECT animal.*, IFNULL(raca, 'Raca não informada') AS Raca FROM animal;
create database lista6;
use lista6;

create table animal(
id int primary key auto_increment,
nome varchar(45),
especie varchar(45),
raca varchar(45),
idade int
);

create table ficha_medica(
id int primary key auto_increment,
data_ultima_consulta date,
peso decimal(10,2),
vacina_em_dia varchar(3) 
	check (vacina_em_dia in ('sim', 'nao')),
observacao varchar(10000),
fk_animal int,
constraint fkAniFicha 
	foreign key(fk_animal) references animal(id)
);

insert into animal (nome, especie, raca, idade) values
('thor', 'cão', 'bulldog', 3),
('luna', 'gato', 'persa', 2),
('rex', 'cão', 'pastor alemão', 5),
('mimi', 'gato', 'siamês', 1),
('bob', 'cão', 'poodle', 4);

insert into ficha_medica (data_ultima_consulta, peso, vacina_em_dia, observacao, fk_animal) values
('2026-01-10', 12.50, 'sim', 'check-up de rotina sem alterações.', 1),
('2026-02-15', 4.20, 'sim', 'vacinas aplicadas com sucesso.', 2),
('2026-03-01', 28.00, 'nao', 'pendente vacina da raiva.', 3),
('2026-03-20', 3.80, 'sim', 'tratamento de desparasitação concluído.', 4);

select * from animal;
select * from ficha_medica;

insert into ficha_medica (data_ultima_consulta, peso, vacina_em_dia, observacao, fk_animal) values
('2026-04-05', 13.00, 'sim', 'consulta de retorno para o mesmo animal.', 1);

DELETE FROM ficha_medica WHERE id = 5;

alter table ficha_medica modify column fk_animal int unique;

select nome as Nome, especie as Especie from animal;

select*from ficha_medica where vacina_em_dia = 'nao';

select*from animal order by idade desc;

select*from animal where especie = 'cão';

SELECT nome AS Pet, especie AS Tipo FROM animal;

SELECT peso AS 'Peso(kg)', data_ultima_consulta AS 'Ultima Consulta' FROM ficha_medica;

SELECT idade, (idade * 7) AS 'Idade Humana Aproximada' FROM animal;

SELECT nome AS 'Nome do Pet', especie AS 'Raça/Tipo' from animal;

SELECT nome AS Nome,
 CASE
   WHEN idade < 2 THEN 'FIlhote'
   WHEN idade >= 2 AND idade <= 7 THEN 'Adulto'
   ELSE 'Idoso'
   END AS fase_vida
   FROM animal;
   
SELECT nome AS Nome,
	CASE
    WHEN vacina_em_dia = 'sim' THEN 'Vacinado'
    ELSE 'Pendente'
    END AS Vacinacao
    FROM animal JOIN ficha_medica
    ON animal.id = fk_animal;
    
SELECT
	CASE
    WHEN peso < 5 THEN 'Pequeno'
    WHEN peso >= 5 AND peso <= 20 THEN 'Médio'
    ELSE 'Grande'
    END AS Porte
    FROM ficha_medica;
    
SELECT nome,
	CASE
    WHEN especie = 'cão' THEN 'Canino'
    WHEN especie = 'gato' THEN 'Felino'
    ELSE 'Outro'
    END AS especie_tipo
    FROM animal;

UPDATE ficha_medica SET observacao = null 
	WHERE id = 4;
    
SELECT*FROM ficha_medica;

SELECT nome AS Nome, 
ifnull(observacao,'Nenhuma observacao') AS 'Observação'
FROM animal JOIN ficha_medica
ON animal.id = fk_animal;
 
UPDATE ficha_medica SET data_ultima_consulta = null 
	WHERE id = 3;
    
SELECT animal.*, ifnull(data_ultima_consulta, 'SEM FICHA') AS Ficha
FROM animal LEFT JOIN ficha_medica
ON animal.id = ficha_medica.fk_animal;

SELECT nome, peso, data_ultima_consulta 
FROM animal INNER JOIN ficha_medica
ON animal.id = fk_animal;

SELECT concat(nome, ' - ', especie,' - ',peso) AS Resumo
FROM animal INNER JOIN ficha_medica
ON animal.id = ficha_medica.fk_animal;

UPDATE animal SET raca = null WHERE id = 2;

SELECT animal.*, ifnull(raca,'Raça não informada') AS Raca FROM animal;

-- ----------------------------------------------------------------------- --
-- 2. Farmácia
USE sprint2;

CREATE TABLE farmacia(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
cnpj CHAR(14)
);

CREATE TABLE endereco(
id INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(55),
numero INT,
bairro VARCHAR(45),
cidade VARCHAR(45),
fk_farmacia INT,
CONSTRAINT fkFarmaEnd FOREIGN KEY(fk_farmacia) REFERENCES farmacia(id)
);

CREATE TABLE farmaceutico(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
crf INT,
turno VARCHAR(30) CHECK (turno IN('Manha', 'Tarde', 'Noite')),
fk_farmacia INT,
CONSTRAINT fkFarmaCeu FOREIGN KEY(fk_farmacia) REFERENCES farmacia(id)
);

ALTER TABLE endereco MODIFY COLUMN fk_farmacia INT UNIQUE;

INSERT INTO farmacia (nome, cpnj) VALUES
('Drogasil', '12345678000101'),
('Droga Raia', '23456789000102'),
('Pague Menos', '34567890000103');

INSERT INTO endereco (rua, numero, bairro, cidade, fk_farmacia) VALUES
('Rua Augusta', 100, 'Consolação', 'São Paulo', 1),
('Avenida Paulista', 1500, 'Bela Vista', 'São Paulo', 2);

INSERT INTO farmaceutico (nome, crf, turno, fk_farmacia) VALUES
('João Silva', 12345, 'Manha', 1),
('Maria Santos', 23456, 'Tarde', 1),
('Carlos Oliveira', 34567, 'Noite', 2),
('Ana Souza', 45678, 'Manha', 2),
('Pedro Costa', 56789, 'Tarde', 3);

SELECT * FROM farmacia;

SELECT * FROM endereco;

SELECT * FROM farmaceutico;

INSERT INTO endereco (rua, numero, bairro, cidade, fk_farmacia) VALUES
('Rua Vergueiro', 500, 'Liberdade', 'São Paulo', 3);

SELECT nome, cnpj FROM farmacia;

SELECT*FROM farmaceutico WHERE turno = 'Noite';

SELECT*FROM endereco ORDER BY cidade;

SELECT nome, crf FROM farmaceutico;

SELECT nome AS Estabelecimento, cnpj AS Documento FROM farmacia;

SELECT nome AS Profissional, turno AS 'Horário de Trabalho' FROM farmaceutico;

SELECT rua AS Logadouro, numero AS Num FROM endereco;

SELECT concat(rua, ' - ',numero,'Nº') AS 'Endereco Completo' FROM endereco;

SELECT nome,
	CASE
    WHEN turno = 'Manha' THEN '06h-12h'
    WHEN turno = 'Tarde' THEN '12h-18h'
    ELSE '18h-00h'
    END AS Periodo
    FROM farmaceutico;
    
SELECT nome,
	CASE
    WHEN cnpj LIKE '1%' THEN 'Matriz'
    ELSE 'Filial'
    END AS tipo_cnpj
    FROM farmacia;
    
SELECT*FROM endereco;
DESC endereco;
DROP TABLE endereco;

INSERT INTO endereco (rua, numero, bairro, cidade, fk_farmacia) VALUES
('Avenida Nova Cantareira', 1200, 'Tucuruvi', 'São Paulo', 1),
('Avenida Jabaquara', 1500, 'Saúde', 'São Paulo', 2);

SELECT bairro,
	CASE
    WHEN bairro = 'Tucuruvi' THEN 'Zona Norte'
    WHEN bairro = 'Saúde' THEN 'Zona Sul'
    ELSE 'Outra'
    END AS 'Zona'
    FROM endereco;
    
SELECT nome,
	CASE
    WHEN turno = 'Noite' THEN 'Adicional Noturno'
    ELSE 'Normal'
    END AS 'Carga_horaria'
    FROM farmaceutico;
    
UPDATE endereco SET rua = NULL WHERE id = 3;

SELECT nome, ifnull(rua, 'SEM ENDERECO') 
FROM farmacia LEFT JOIN endereco ON farmacia.id = endereco.fk_farmacia;

SELECT farmaceutico.nome, farmaceutico.crf, farmacia.nome 
FROM farmaceutico INNER JOIN farmacia ON farmacia.id = farmaceutico.fk_farmacia;

SELECT farmacia.nome, endereco.cidade, farmaceutico.nome 
FROM farmacia
INNER JOIN farmaceutico
    ON farmacia.id = farmaceutico.fk_farmacia
INNER JOIN endereco
    ON farmacia.id = endereco.fk_farmacia;
    
SELECT concat(farmaceutico.nome, ' - ',farmaceutico.crf, ' - ', farmacia.nome) AS Info
FROM farmaceutico INNER JOIN farmacia ON farmacia.id = farmaceutico.fk_farmacia;

UPDATE endereco SET bairro = null WHERE id = 2;

SELECT endereco.*, ifnull(endereco.bairro, 'Bairro não informado') FROM endereco;

-- ------------------------------------------------------------------------------------------------ --7
-- 3. Streaming de Música

CREATE TABLE artista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    genero_musical VARCHAR(50),
    pais VARCHAR(50),
    ativo BOOLEAN
);

CREATE TABLE musica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    duracao_segundos INT,
    ano_lancamento YEAR,
    fk_artista INT,
    CONSTRAINT fkArtistaMusica FOREIGN KEY (fk_artista) REFERENCES artista(id)
);

INSERT INTO artista (nome, genero_musical, pais, ativo) VALUES
('The Weeknd', 'Pop', NULL, TRUE),
('Imagine Dragons', 'Rock', 'Estados Unidos', TRUE),
('Anitta', 'Pop', 'Brasil', TRUE);

INSERT INTO musica (titulo, duracao_segundos, ano_lancamento, fk_artista) VALUES
('Blinding Lights', 200, 2019, 1),
('Believer', 204, 2017, 2),
('Envolver', 194, 2021, 3),
('Thunder', 187, 2017, 2),
(NULL, 210, 2024, NULL);

SELECT * FROM artista;

SELECT * FROM musica;

SELECT titulo, duracao_segundos FROM musica;

SELECT*FROM musica WHERE ano_lancamento = 2020;

SELECT nome FROM artista ORDER BY nome ASC;

SELECT*FROM musica WHERE duracao_segundos > 200;

SELECT titulo AS 'Nome da Musica', ano_lancamento AS 'Ano' FROM musica;

SELECT nome AS 'Cantor/Banda', genero_musical AS 'Estilo' FROM artista;

SELECT duracao_segundos/60 AS 'Duração (min)' FROM musica;

SELECT titulo AS 'Faixa', ano_lancamento AS 'Lançamento' FROM musica;






create database exBancoGP;
use exBancoGP;

create table usuario(
id_usuario int primary key auto_increment,
nome varchar(40),
senha char(8) not null, 
email varchar(40) not null constraint chkEmail check(email like '%@%'),
cnpj char(14),
telefone int(9)
);

create table sensor(
id_sensor int primary key auto_increment,
codigo_sensor int unique,
sensor varchar(15),
local_alocado varchar(20),
intensidadeLuminosidade_ideal decimal(10,2) default 800.00 ,
statuss varchar(10)
constraint chkStatuss check(statuss in('ativo','inativo'))
);

create table leitura(
id_leitura int primary key auto_increment,
codigo_sensor int,
luminosidade decimal(10,2),
instesidade decimal(10,2),
data_leitura datetime default current_timestamp
);

create table produto(
id_prod int primary key auto_increment,
nome_produto varchar(30),
preco_médio decimal(10,2),
fase_crescimento varchar(20)
);
describe sensor;
select*from usuario;
drop table leitura;
select*from sensor;

insert into usuario (nome, senha, email, cnpj, telefone) values
('Tecnologia Avançada LTDA', 'tec@2026', 'suporte@tecavancada.com', '98765432000100', 912345678),
('Mariana Costa', 'mari1234', 'mariana.costa@gmail.com', NULL, 998877665),
('Distribuidora Global', 'glob#987', 'vendas@global.com.br', '11223344000155', 987654321),
('Lucas Oliveira', 'pwd123', 'lucas.oli@outlook.com', NULL, NULL),
('Padaria do Bairro', 'paoquent', 'contato@padariabairro.com', '55667788000122', 955554444),
('Ana Beatriz', 'anab4321', 'anabeatriz@hotmail.com', NULL, 911112222),
('Consultoria Express', 'cx9876', 'financeiro@cexpress.com', '44332211000199', NULL);

insert into sensor (codigo_sensor, sensor, local_alocado, intensidadeLuminosidade_ideal, statuss) values
(101, 'LDR Lux', 'Estufa 1', '800.00', 'ativo'),
(102, 'LDR Lux', 'Estufa 2', 275.50, 'ativo'),
(103, 'LDR Lux', 'Estufa 1', 456.00, 'ativo'),
(104, 'LDR Lux', 'Estufa 4', 350.00, 'inativo'),
(105, 'LDR Lux', 'Estufa 18', 589.00, 'ativo'),
(106, 'LDR Lux', 'Estufa 3', 501.00, 'inativo');

insert into leitura (codigo_sensor, luminosidade, instesidade, data_leitura) values
(101, 150.00, 150.00, '2026-09-08 08:00:00'),
(102, 180.50, 180.00, '2026-09-08 09:00:00'),
(105, 210.00, 205.00, '2026-09-08 10:00:00');

insert into leitura (codigo_sensor, luminosidade, instesidade) values
(104, 270.00, 265.00),
(103, 280.00, 195.00),
(106, 275.50, 270.00);

insert into produto (nome_produto, preco_médio, fase_crescimento) values
('Baunilha Gourmet Premium', 150.00, 'Fase C'),
('Kit Sensores LDR Lux', 85.50, 'Fase A'),
('Extrato de Baunilha 100ml', 45.00, 'Fase C'),
('Muda de Vanilla Planifolia', 60.00, 'Fase A'),
('Painel LED Full Spectrum', 450.00, 'Fase B'),
('Fertilizante Orgânico Orquídea', 29.90, 'Fase B');

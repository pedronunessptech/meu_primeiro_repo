create database sprint2;
use sprint2;

create table atleta(
idAtleta int primary key auto_increment,
nome varchar(40),
modalidade varchar(40),
qtdMedalha int
);

insert into atleta values
(default,'Josefino','Salto com vara',5),
(default,'Andreia','Salto com vara',2),
(default,'Luis','Ping-pong',9),
(default,'Delma','Ping-pong',6),
(default,'Karina','Voleiball',0),
(default,'Felipo','Voleiball',1);

create table pais(
idPais int primary key auto_increment,
nome varchar(30),
capital varchar(40)
);

insert into pais values
(default,'Brasil','Brasilia'),
(default,'Canadá','Toronto'),
(default,'Holanda','Amsterdã'),
(default,'Coreira do Sul','Seoul');

alter table atleta add column fkPais int ;
alter table atleta add constraint fkPaisAtleta foreign key(fkPais) references pais(idPais);
alter table atleta drop constraint fkPaisAtleta;

update atleta set fkPais = 1 where idAtleta=1 ;

update atleta set fkPais = 2 where idAtleta=2 ;

update atleta set fkPais = 3 where idAtleta=3 ;

update atleta set fkPais = 4 where idAtleta=4 ;

update atleta set fkPais = 1 where idAtleta=5 ;

update atleta set fkPais = 2 where idAtleta=6 ;

select*from atleta;
select*from pais;

describe atleta;

drop table atleta;

select atleta.nome as Nome, pais.nome as Pais from atleta join pais where fkPais = idPais;

select*from atleta join pais on fkPais = idPais where capital = 'Brasilia';


-- ---------------------------------------------------------------------------- --
-- Exercicio 2 --
use sprint2;

create table Musica(
idMusica int primary key auto_increment,
titulo varchar(40),
artista varchar(40),
genero varchar (40)
);

create table Album(
idAlbum int primary key auto_increment,
nome varchar(40),
tipo char(9),
constraint chkTipo check (tipo in('Digital', 'Fisico'))
);

insert into Album values
(default,'Give or Take','Digital'),
(default,'Chromakopia','Digital');

insert into Musica values
(default,'Unholy Matrimony','Giveon','R&B'),
(default,'Scarred','Giveon','R&B'),
(default,'Noid','Tyler the creator','Hip-hop'),
(default,'Like him','Tyler the creator','Hip-hop');

alter table Musica add column fkAlbum int;
alter table Musica drop column fkAlbum;
alter table Musica add constraint fkAlbumMusica foreign key(fkAlbum) references Album(idAlbum);
alter table Musica drop constraint fkAlbumMusica;

update Musica set fkAlbum = 1 where idMusica=1 ;
update Musica set fkAlbum = 1 where idMusica=2 ;
update Musica set fkAlbum = 2 where idMusica=3 ;
update Musica set fkAlbum = 2 where idMusica=4 ;


select*from Musica;

select Musica.titulo as Titulo, Album.nome as Album from Musica join Album where fkAlbum = idAlbum;

select Musica.titulo as Titulo, Album.nome as Album, Musica.genero as Genero from Musica join Album where fkAlbum = idAlbum and genero = 'R&B';

-- ---------------------------------------------------------------------------- --
-- Exercicio 3 --
use sprint2;

create table pessoa (
    idpessoa int primary key auto_increment,
    nome varchar(45),
    cpf char(11)
);

create table reserva (
    idreserva int primary key auto_increment,
    dtreserva datetime,
    dtretirada datetime,
    dtdevolucao datetime,
    fkpessoa int
)auto_increment=100;

insert into pessoa (idpessoa, nome, cpf) values 
(default, 'Ana Silva', '12345678901'),
(default, 'Bruno Souza', '23456789012'),
(default, 'Carla Oliveira', '34567890123'),
(default, 'Diego Santos', '45678901234'),
(default, 'Elena Costa', '56789012345');

insert into reserva (idreserva, dtreserva, dtretirada, dtdevolucao, fkpessoa) values 
(default, '2026-09-10 10:00:00', '2026-09-11 08:00:00', '2026-09-15 18:00:00', 1),
(default, '2026-09-12 14:30:00', '2026-09-13 09:00:00', '2026-09-14 17:00:00', 2),
(default, '2026-09-14 11:15:00', '2026-09-15 10:00:00', '2026-09-20 12:00:00', 3),
(default, '2026-09-15 16:00:00', '2026-09-16 14:00:00', '2026-09-18 14:00:00', 4),
(default, '2026-09-16 09:45:00', '2026-09-17 08:30:00', '2026-09-22 18:00:00', 5);
 
 alter table reserva add constraint fkPessoaReserva foreign key(fkpessoa) references pessoa(idpessoa);
 
 update reserva set fkpessoa = 1 where idreserva = 101;
 update reserva set fkpessoa = 1 where idreserva = 102;
 update reserva set fkpessoa = 3 where idreserva = 103;
 update reserva set fkpessoa = 5 where idreserva = 104;
 update reserva set fkpessoa = 4 where idreserva = 100;
 
select*from reserva;

select reserva.idreserva as Codigo, reserva.dtreserva as Dia, pessoa.nome as NomeCliente from reserva join pessoa where fkpessoa = idpessoa;

update pessoa set cpf = null where idpessoa = 1;

select ifnull(cpf,'Estrangeiro(a)') as CPF,
	concat('Quem fez a reserva: ',nome) as Nome,
    case
		when fkpessoa > 0 then 'Fez reserva'
        end as RESERVA
        from pessoa join reserva where fkpessoa = idpessoa;
        
-- ---------------------------------------------------------------------------- --
-- Exercicio 4 --
use sprint2;

create table Pessoa1(
idPessoa1 int primary key auto_increment,
nome varchar(45),
dtNascimneto date
);

create table Pessoa2(
idPessoa2 int primary key auto_increment,
nome varchar(45),
dtNascimneto date,
fkPessoa1 int
) auto_increment = 10;      

insert into Pessoa1 values 
(default, 'Carlos Silva', '1990-05-15'),
(default, 'Ana Souza', '1985-10-22'),
(default, 'Roberto Santos', '1998-03-09'),
(default, 'Juliana Lima', '1993-07-25'),
(default, 'Ricardo Alves', '1979-12-12');

insert into Pessoa2 values 
(default, 'Mariana Silva', '2015-08-12', 1),
(default, 'Lucas Silva', '2018-01-30', 1),
(default, 'Beatriz Souza', '2012-11-05', 2),
(default, 'Gabriel Santos', '2020-04-18', 3),
(default, 'Fernanda Lima', '2016-09-02', 4);

 alter table Pessoa2 add constraint fkPessoa1Pessoa2 foreign key(fkPessoa1) references Pessoa1(idPessoa1);

select*from Pessoa2;

select Pessoa1.nome as NOME1, Pessoa2.nome as NOME2 from Pessoa1 join Pessoa2 where fkPessoa1 = idPessoa1;
update Pessoa2 set nome = null where idPessoa2 = 10;
alter table Pessoa2 rename column nome to nome2;

select ifnull(nome,'Sem nome') as NOME,
	case 
		when fkPessoa1 > 0 then 'Tem alguem correlacionado'
        end as CORRELACIONAMENTO
        from Pessoa2 join Pessoa1 where fkPessoa1 = idPessoa1;
        
-- -------------------------------------------------------------------- --
-- Exercicio 5 --

use sprint2;


create table candidato (
    idCandidato int auto_increment primary key,
    nome varchar(45) not null,
    cpf varchar(11) not null unique,
    data_nascimento date not null
);

create table primeira_habilitacao (
    idHabilitacao int auto_increment primary key,
    fkCandidato int not null unique,
    categoria varchar(10) not null check (categoria in ('A', 'B', 'A e B', 'ACC', 'ACC e B')),
    data_emissao date not null,
    data_validade date not null,
    status varchar(20) default 'em andamento'
);

insert into candidato (nome, cpf, data_nascimento) values
('lucas oliveira', '11122233344', '2005-05-12'),
('mariana santos', '22233344455', '2004-11-03'),
('carlos eduardo', '33344455566', '2006-01-20'),
('beatriz costa', '44455566677', '2003-08-15'),
('gabriel souza', '55566677788', '2005-12-01');


insert into primeira_habilitacao (fkCandidato, categoria, data_emissao, data_validade, status) values
(1, 'A', '2026-01-10', '2027-01-10', 'ativa'),
(2, 'B', '2026-02-15', '2027-02-15', 'ativa'),
(3, 'A e B', '2026-03-20', '2027-03-20', 'em andamento'),
(4, 'ACC', '2026-04-05', '2027-04-05', 'ativa'),
(5, 'ACC e B', '2026-05-18', '2027-05-18', 'em andamento');

alter table primeira_habilitacao rename column status to statuss;
alter table primeira_habilitacao add constraint fkCandidatoHabi foreign key(fkCandidato) references candidato(idCandidato);

select*from candidato;
select*from primeira_habilitacao;

select 
    candidato.nome as nome_candidato,
    candidato.cpf as documento_cpf,
    primeira_habilitacao.categoria as categoria_habilitacao,
    primeira_habilitacao.statuss as situacao_processo
from candidato join primeira_habilitacao where idCandidato = fkCandidato;

select 
    candidato.nome,
    primeira_habilitacao.categoria,
    case 
        when primeira_habilitacao.categoria = 'A e B' then 'categoria dupla (moto e carro)'
        when primeira_habilitacao.categoria = 'A' then 'apenas motociclo'
        when primeira_habilitacao.categoria = 'B' then 'apenas automóvel'
        else 'ciclomotor/acc'
    end as descricao_categoria
from candidato join primeira_habilitacao where idCandidato = fkCandidato;

insert into candidato (nome, cpf, data_nascimento) values 
('rodrigo alves', '66677788899', '2002-09-10');

insert into primeira_habilitacao (fkCandidato, categoria, data_emissao, data_validade, statuss) values 
(6, 'A', '2026-06-01', '2027-06-01', null);

select 
    candidato.nome as nome_candidato,
    ifnull(primeira_habilitacao.categoria, 'sem categoria') as categoria_habilitacao,
    ifnull(primeira_habilitacao.statuss, 'não iniciado') as status_processo
from candidato join primeira_habilitacao
where idCandidato = fkCandidato;

-- ----------------------------------------------------------------------------------------------------------------------------- --
-- Exercicio 6 --

use sprint2;

create table farmacia (
idfarmacia int primary key auto_increment,
nome varchar(45),
telefone varchar(20)
);

create table endereco (
idendereco int primary key auto_increment,
rua varchar(45),
bairro varchar(45),
fkfarmacia int unique
);

create table farmaceutico (
idfarmaceutico int primary key auto_increment,
nome varchar(45),
cpf varchar(11),
fkfarmacia int
);

insert into farmacia values
(default, 'farmacia sp', '11999990001'),
(default, 'farmacia vida', '11999990002'),
(default, 'farmacia saude', '11999990003'),
(default, 'farmacia popular', '11999990004'),
(default, 'farmacia bem estar', '11999990005');

insert into endereco values
(default, 'rua a', 'centro', 1),
(default, 'rua b', 'jardins', 2),
(default, 'rua c', 'mooca', 3),
(default, 'rua d', 'pinheiros', 4),
(default, 'rua e', 'tatuape', 5);

insert into farmaceutico values
(default, 'carlos silva', '12345678901', 1),
(default, 'ana souza', '23456789012', 1),
(default, 'marcos lima', '34567890123', 2),
(default, 'julia costa', '45678901234', 3),
(default, 'paulo santos', '56789012345', 4);

alter table endereco add constraint fkfarmaciaendereco foreign key(fkfarmacia) references farmacia(idfarmacia);
alter table farmaceutico add constraint fkfarmaciafarmaceutico foreign key(fkfarmacia) references farmacia(idfarmacia);

select*from farmacia;
select*from endereco;
select*from farmaceutico;

select farmacia.nome, endereco.rua, farmaceutico.nome from farmacia join endereco join farmaceutico where endereco.fkfarmacia = farmacia.idfarmacia and farmaceutico.fkfarmacia = farmacia.idfarmacia;

select farmacia.nome as nomefarmacia, endereco.rua as ruafarmacia, farmaceutico.nome as nomefarmaceutico from farmacia join endereco join farmaceutico where endereco.fkfarmacia = farmacia.idfarmacia and farmaceutico.fkfarmacia = farmacia.idfarmacia;

select farmaceutico.nome,
    case
        when farmaceutico.fkfarmacia > 0 then 'contratado'
    end as statuscontrato
from farmaceutico join farmacia where farmaceutico.fkfarmacia = farmacia.idfarmacia;

select ifnull(farmaceutico.cpf, 'sem cpf') as cpf,
    farmaceutico.nome as nomefarmaceutico
from farmaceutico join farmacia where farmaceutico.fkfarmacia = farmacia.idfarmacia;
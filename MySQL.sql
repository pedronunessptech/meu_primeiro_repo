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
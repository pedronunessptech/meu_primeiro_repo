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
/*
Criar a tabela chamada Album para conter os dados: idAlbum, nome, tipo (digital
ou físico) e dtLancamento (DATE)
*/
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






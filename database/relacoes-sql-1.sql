-- Active: 1681228093839@@127.0.0.1@3306


-- Práticas

--1 e 2--

-- diferente do primary key que vai junto com os outros atributosa na coluna, o foreign key vem depois da declaração das colunas. vem a foreing key (entre parenteses qual coluna tera a chave) REFERENCES a outra tabela (o atributo da outra tabela entre parenteses tbm) --
-- na relação um pra muitos, a a coluna da foreign key não é unica
CREATE TABLE phones(
    id TEXT NOT NULL UNIQUE PRIMARY KEY,
    phone_number TEXT NOT NULL UNIQUE,
    user_id TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE phones;

DROP TABLE users;

CREATE TABLE users(
    id TEXT NOT NULL UNIQUE PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL

);



INSERT INTO users (id, name, email, password)
VALUES
("123456789", "everton", "everton@email", "111222"),
("987654321", "maria", "maria@email", "333444");


INSERT INTO phones (id, phone_number, user_id)
VALUES
("1", "11-98745-5555", "123456789"),
("2", "11-93214-5566", "987654321"),
("3", "11-91324-6478", "123456789");

-- para mostarr as duas tabelas select a primeira, inner join com a outra e precisa especificar onde ocorre a união das tabelas.email --
--versao 1 --

-- para acessar uma coluna de uma tabela: tabela.coluna (igual objeto)
SELECT * FROM phones
INNER JOIN users
ON phones.user_id = users.id;

--versao 2 -- 
SELECT * FROM users
INNER JOIN phones
ON phones.user_id = users.id;


-- PRATICA 3--

CREATE TABLE licenses(
    id TEXT UNIQUE NOT NULL PRIMARY KEY,
    register_number TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL
);

-- na relação um pra um, a coluna da foreign key é unique, diferente da 1 pra muitos
CREATE TABLE drivers(
    id TEXT UNIQUE NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    license_id TEXT UNIQUE NOT NULL,
    FOREIGN KEY (license_id) REFERENCES licenses (id)
);

INSERT INTO licenses (id, register_number,category)
VALUES
("L001", "1234", "A"),
("L002", "12345", "B"),
("L003", "123456", "D"),
("L004", "1234567", "AB");

INSERT INTO drivers (id, name, email, password, license_id)
VALUES
("D001", "rogerinho", "rogerinho@email.com", "123", "L001"),
("D002", "Renan", "renan@email.com", "456", "L002"),
("D003", "Marueilio", "maurilio@email.com", "789", "L003"),
("D004", "julinho", "julinho@email.com", "987654", "L004");


-- join mostrandpo colunas espcificas da junção
-- pegando tudo
SELECT * FROM drivers
INNER JOIN licenses
ON drivers.license_id = licenses.id;

-- colunas especifcias
--OBS eu posso selceionar as colunas das duas tabelas
SELECT drivers.id as IdDoMotorista, name, email, register_number, category FROM drivers
INNER JOIN licenses
ON drivers.license_id = licenses.id;

--fixação--

--1:m--

CREATE TABLE mangas(
    id TEXT UNIQUE NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,    
    volumes INTEGER NOT NULL,
    magazine TEXT NOT NULL,
    date INTEGER NOT NULL,   
    author TEXT NOT NULL,
    Foreign Key (author) REFERENCES authors(id)

);

DROP TABLE mangas;

CREATE TABLE authors(
    id TEXT UNIQUE NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
);

DROP TABLE authors;


INSERT INTO authors (id, name)
VALUES
("A001", "Masami Kurumada"),
("A002", "Arakawa"),
("A003", "Kishimoto");

INSERT INTO mangas  (id, name, volumes, magazine, date, author)
VALUES
("m001", "CDZ", 32, "Shonen Jump", 1978, "A001"),
("m002", "Fulmmetal", 27, "Shonen gangan", 2000, "A002"),
("m003", "Ring ni kakero", 28, "shonen jump", 1975, "A001" ),
("m004", "naruto", 73, "shonen jump", 2001, "A003"),
("m005", "fummma no kojiro", 15, "camhmpion red", 1800, "A001");

SELECT mangas.id, mangas.name, volumes, authors.name FROM mangas
INNER JOIN authors
ON mangas.author = authors.id;


-- fixação 1:1 --

CREATE TABLE cpf (
    id INTEGER UNIQUE NOT NULL PRIMARY KEY,
    numero TEXT UNIQUE NOT NULL
    

);

DROP TABLE cpf;

CREATE TABLE cidadao(
    id TEXT UNIQUE NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    endereco TEXT NOT NULL,
    estado_civil TEXT NOT NULL,
    documento INTEGER UNIQUE NOT NULL,
    FOREIGN KEY(documento) REFERENCES cpf(numero)
);

DROP TABLE cidadao;

INSERT INTO cpf (id, numero)
VALUES
(00001, "364.555.108-52"),
(00002, "457.896.632-89"),
(00003, "145.254.236-53");


INSERT INTO cidadao (id, name, endereco, estado_civil,documento)
VALUES
("C001", "joaquim", "rua dos bobos", "solteiro", "364.555.108-52"),
("C002", "josefina", "rua dos tontos", "viuva", "457.896.632-89"),
("C003", "Josequim", "rua dos bobos tontos", "casado", "145.254.236-53");

SELECT cidadao.name, cidadao.id, cpf.numero as identficacao FROM cidadao
INNER JOIN cpf
ON cidadao.documento = cpf.numero;
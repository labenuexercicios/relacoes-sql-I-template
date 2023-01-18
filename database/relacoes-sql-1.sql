-- Active: 1674043415330@@127.0.0.1@3306


-- Práticas 1 e 2 1:M ("um" pra "muitos" modelos)
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE phones (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    phone_number TEXT UNIQUE NOT NULL,
    user_id TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (id, name, email, password)
VALUES 
("u001", "Camilla", "camilla@email.com", "camilla123"),
("u002", "Igor", "igor@email.com", "igor123");


INSERT INTO phones (id, phone_number, user_id)
VALUES
("p001", "5514984262526", "u001"),
("p002", "5519991245553", "u001"),
("p003", "5511992342521", "u002");


INSERT INTO phones (id, phone_number, user_id)
VALUES
("p001", "551498426212", "u003");

DELETE FROM phones
WHERE user_id = "u003";

DROP TABLE users;
DROP TABLE phones;

SELECT * FROM users;
SELECT * FROM phones;

SELECT * FROM users --TABELA A
INNER JOIN phones --TABELA B
ON phones.user_id = users.id;

-- Prática 3 = 1:1 ("um" pra "um" modelo)
CREATE TABLE licenses (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    register_number TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL
);

CREATE TABLE drivers (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    license_id TEXT UNIQUE NOT NULL,
    FOREIGN KEY (license_id) REFERENCES licenses (id)
);

INSERT INTO licenses (id, register_number, category)
VALUES
("l001", "111111111", "A"),
("l002", "222222222", "AB");

INSERT INTO drivers (id, name, email, password, license_id)
VALUES
("d001", "Carlos Bergson", "carlosb@email.com", "carlosbbb", "l001"),
("d002", "Tais Zimerer", "zimerertais@email.com", "taisbbb", "l002");

SELECT * FROM drivers
INNER JOIN licenses
ON drivers.license_id = licenses.id;

DROP TABLE drivers;
DROP TABLE licenses;

-- FIXAÇÃO:
CREATE TABLE baby (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT UNIQUE NOT NULL,
    category TEXT UNIQUE NOT NULL
);

CREATE TABLE diapers (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    baby_id TEXT NOT NULL,
    FOREIGN KEY (baby_id) REFERENCES baby (id)
);
-- O "baby_id" DO FOREIGN KEY na tabela b deve ser 
-- correspondente(igual) ao PRIMARY KEY id 


DROP TABLE diapers;

INSERT INTO baby (id, name, category)
VALUES
("b01", "Pedro David", "son");

INSERT INTO diapers (id, name, type, baby_id)
VALUES
("d01","Huggies", "Cloth Diapers", "b01"),
("d02", "Pampers", "Disposable diapers", "b01");


SELECT * FROM baby;
SELECT * FROM diapers;
SELECT * FROM baby --TABELA A
INNER JOIN diapers --TABELA B
ON diapers.baby_id = baby.id;

DROP TABLE baby;

DROP TABLE diapers;
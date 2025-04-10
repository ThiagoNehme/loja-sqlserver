
-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE LojaDB;
GO
USE LojaDB;
GO

-- SEQUENCE PARA PESSOA
CREATE SEQUENCE seq_id_pessoa START WITH 1 INCREMENT BY 1;
GO

-- USUÁRIOS
CREATE TABLE Usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL
);
GO

-- PESSOAS
CREATE TABLE Pessoa (
    id INT PRIMARY KEY DEFAULT NEXT VALUE FOR seq_id_pessoa,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(100),
    tipo CHAR(1) CHECK (tipo IN ('F', 'J'))
);
GO

CREATE TABLE PessoaFisica (
    id_pessoa INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);
GO

CREATE TABLE PessoaJuridica (
    id_pessoa INT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);
GO

-- PRODUTOS
CREATE TABLE Produto (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL
);
GO

-- MOVIMENTAÇÕES
CREATE TABLE Movimentacao (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tipo CHAR(1) CHECK (tipo IN ('E', 'S')) NOT NULL,
    id_usuario INT NOT NULL,
    id_produto INT NOT NULL,
    id_pessoa INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    data DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id)
);
GO

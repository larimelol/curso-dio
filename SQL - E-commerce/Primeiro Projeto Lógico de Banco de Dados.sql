-- Criação do banco de dados para o cenário de E-commerce

CREATE DATABASE ecommerce;
USE ecommerce;

-- Criar tabela Cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10) NOT NULL,
    Minit CHAR(5),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    CEP CHAR(8) NOT NULL,
    Street VARCHAR(15) NOT NULL,
    District VARCHAR(10) NOT NULL,
    City VARCHAR(15) NOT NULL,
    State VARCHAR(10) NOT NULL,
    Birthday DATE NOT NULL,
    CONSTRAINT unique_cpf_cliente UNIQUE(CPF)
);

-- Criar tabela Produto
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    Classification_kids BOOL DEFAULT FALSE,
    Category ENUM('Eletronico','Vestuário','Beleza e Cuidados Pessoais','Casa e Jardim','Esportes','Games','Infantil','Livros','Brinquedos','Automotivo','Alimentação','Papelaria e Escritório','Ferramentas e Construção','Pet Shop') NOT NULL,
    Discription VARCHAR(45),
    Avaliation FLOAT DEFAULT 0,
    Price FLOAT
);

-- Criar tabela de Pagamentos
CREATE TABLE payments(
	idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto','Cartão','Dois Cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY (idClient, idPayment)
);

-- Criar tabela Pedido
CREATE TABLE orders(
	idOrders INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Em Andamento', 'Processando', 'Cancelado', 'Enviado', 'Entregue') DEFAULT 'Processando',
    ordersDiscription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
		on update cascade
        on delete set null
);

-- Criar tabela Estoque
CREATE TABLE productStorage(
	idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quality INT DEFAULT 0
);


-- Criar tabela Fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);


-- Criar tabela Vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(14),
    CPF CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
    CONSTRAINT unique_CPF_seller UNIQUE (CPF)
);

CREATE TABLE productSeller(
	idPseller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponivel', 'Sem Estoque') DEFAULT 'Disponivel',
    PRIMARY KEY (idPOproduct, idPOorder),
	CONSTRAINT fk_productorder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrders)
);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
	CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProductStorage)
);



-- DROP ROLE b2bUser 
CREATE ROLE b2bUser WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'b2bUser';
	
	
-- DROP DATABASE B2BEcommerce
CREATE DATABASE B2BEcommerce
    WITH
    OWNER = b2bUser
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Ireland.1252'
    LC_CTYPE = 'English_Ireland.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

GRANT ALL ON DATABASE B2BEcommerce TO b2bUser;
GRANT ALL ON DATABASE B2BEcommerce TO postgres;
GRANT TEMPORARY, CONNECT ON DATABASE B2BEcommerce TO PUBLIC;

-- DROP TABLE Gender CASCADE;
CREATE TABLE Gender (
	GenderId integer primary key,
	geneder varchar(1),
	description varchar(32),
	
	CHECK (LENGTH(geneder)=1)
);

-- DROP TABLE Nationality CASCADE;
CREATE TABLE Nationality (
	nationalityId integer PRIMARY KEY,
	nationName varchar(50) NOT NULL,
	nationality varchar(60) NOT NULL
);

--DROP TABLE City CASCADE;
CREATE TABLE City (
	cityId integer primary key,
	name varchar(30) NOT NULL,
	nationId integer, 
	postalCode varchar(12),
	foreign key(nationId) references Nationality(nationalityId)
);


--DROP TABLE EndCustomer CASCADE;
CREATE TABLE EndCustomer (
	documentNumber varchar(30) primary key,
	username varchar(20) NOT NULL,
	fullName varchar(60) NOT NULL,
	email varchar(40) NOT NULL,
	phoneNumber varchar(18),
	DOB date,
	nationalityId integer,
	genderId integer,
	
	foreign key(nationalityId) references Nationality(nationalityId),
	foreign key(genderId) references Gender(genderId)
);




--DROP TABLE Company CASCADE;
CREATE TABLE Company (
	CUIT varchar(13) primary key,
	name varchar(50) NOT NULL,
	/* city and address refer to the head office*/
	officeAddress varchar(60),
	isSupplier boolean NOT NULL,
	cityId integer,

	foreign key(cityId) references City(cityId)
);


--DROP FUNCTION isCUITSuppplier CASCADE;
CREATE FUNCTION isCUITSuppplier(VARCHAR)
RETURNS BOOLEAN AS 
	'SELECT TRUE
	FROM Company
	WHERE CUIT = $1 AND IsSupplier = TRUE;'
LANGUAGE SQL
IMMUTABLE 
RETURNS NULL ON NULL INPUT;



-- DROP TABLE Category CASCADE;
CREATE TABLE Category (
	categoryId integer primary key,
	category varchar(40) NOT NULL
);



-- DROP TABLE Subcategory CASCADE;
CREATE TABLE Subcategory (
	subcategoryId integer primary key,
	subcategory varchar(40) NOT NULL
);


--DROP TABLE Product CASCADE;
CREATE TABLE Product (
	productId integer primary key,
	name varchar(120) NOT NULL,
	supplierCUIT varchar(13) NOT NULL,
	inStore boolean NOT NULL DEFAULT False,
	fabric varchar(70),
	fit varchar(60),
	origin varchar(60),
	seasonCode varchar(80),
	color varchar(60),
	catalog varchar(80),
	categoryId integer,
	subCategoryId integer,
	defaultPrice numeric(30,2),


	foreign key (supplierCUIT) references Company(CUIT),
	CHECK(defaultPrice>0),
	CHECK(isCUITSuppplier(supplierCUIT) = TRUE)
);



--DROP TABLE CATALOG CASCADE;
CREATE TABLE Catalog (
	catalogId bigint primary key,
	companyCUIT varchar(13) NOT NULL,
	productId integer NOT NULL,

	catalogPrice numeric(30,2) NOT NULL,
	
	foreign key (companyCUIT) references Company(CUIT),
	foreign key (productId) references Product(productId),
	
	/*key(companyCUIT, defaultSupplierProductPrice),*/
	CHECK(catalogPrice > 0),
	CHECK(isCUITSuppplier(companyCUIT) = FALSE),
	UNIQUE (companyCUIT, productId)
);



--DROP TABLE Orders CASCADE;
CREATE TABLE Orders (
	orderId bigint primary key,
	documentNumber varchar(30),
	catalogId bigint,
	quantity integer,
	
	
	foreign key (catalogId) references Catalog(catalogId),
	foreign key (documentNumber) references EndCustomer(documentNumber),
	check(quantity>0),
	UNIQUE(catalogId, documentNumber)
);
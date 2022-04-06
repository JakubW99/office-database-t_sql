
-- Tworzenie bazy danych Biuro
CREATE DATABASE Biuro
GO
-- u¿ycie bazy danych Biuri
USE Biuro
-- utworzenie tabel pracownicy, klienci, sprzêt komputerowy, dokumenty lokalne,
-- dokumenty zagraniczne, godziny pracy oraz slu¿bowe samochody
CREATE TABLE employees
(
employeeId INT IDENTITY(1,1)PRIMARY KEY NOT NULL
,firstName NVARCHAR(20) NOT NULL
,lastName NVARCHAR(30) NOT NULL
,nrPesel Char(11) NOT NULL UNIQUE 
	CHECK(nrPesel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
,mobileNo Char(13)
,insertDate Date NOT NULL DEFAULT GetDate() --'2000-10-31'
CHECK(InsertDate <= GetDate()) 

)

CREATE TABLE clients
(
clientId INT IDENTITY(1,1) PRIMARY KEY
,firstName NVARCHAR(20) NOT NULL
,lastName NVARCHAR(30) NOT NULL
,nrPesel Char(11) NOT NULL UNIQUE 
	CHECK(nrPesel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
,mobileNo Char(13)
,country NVARCHAR(30) 
)

CREATE TABLE hardware
(
hardwareId INT IDENTITY(1,1) PRIMARY KEY
,brand VARCHAR(20) NOT NULL
,model VARCHAR(20) NOT NULL
,guaranteeDate DATE
,employeeID INT NOT NULL
)
CREATE TABLE local_documents
(
documentId INT PRIMARY KEY
,InsertDate Date NOT NULL DEFAULT GetDate()
CHECK(InsertDate <= GetDate()) 
,tax TINYINT NOT NULL DEFAULT '23'
,priceNetto smallmoney NOT NULL
,clientID INT NOT NULL
)
CREATE TABLE foreign_documents
(
documentId INT PRIMARY KEY
,insertDate Date NOT NULL DEFAULT GetDate()
CHECK(InsertDate <= GetDate())
,country NVARCHAR(30)
,isEuropeanUnion BIT NOT NULL -- 1 - true, 0 - false
,tax TINYINT NOT NULL
,priceNetto smallmoney NOT NULL
,clientID INT NOT NULL
)

CREATE TABLE work_hours
(
startdate Date NOT NULL
,enddate Date NOT NULL
,hoursAmount TINYINT NOT NULL
,employeeID INT NOT NULL
)
CREATE TABLE company_cars
(
brand nVarChar(20) NOT NULL
,Model nVarChar(20) NOT NULL
,VIN Char(17) NOT NULL PRIMARY KEY
,RegNo Char(10)
,employeeID INT NOT NULL
)
-- Dodawanie kluczy obcy
ALTER TABLE company_cars
ADD CONSTRAINT employees_company_cars
FOREIGN KEY (employeeID)
REFERENCES employees(employeeID)
GO

ALTER TABLE hardware
ADD CONSTRAINT employeesHardware
FOREIGN KEY (employeeID)
REFERENCES employees(employeeID)
GO

ALTER TABLE work_hours
ADD CONSTRAINT employees_work_hours
FOREIGN KEY (employeeID)
REFERENCES employees(employeeID)
GO

ALTER TABLE local_documents
ADD CONSTRAINT clients_documents
FOREIGN KEY (clientId)
REFERENCES clients(clientId)
GO

ALTER TABLE foreign_documents
ADD CONSTRAINT clients_foreign_documents
FOREIGN KEY (clientId)
REFERENCES clients(clientId)
GO
-- Dodawanie danych do tabel
INSERT employees(firstName,lastName,nrPesel,mobileNo,insertDate)
VALUES ('Nikodem', 'Dyzma','71234568191','511230700','2017-01-01')
INSERT employees(firstName,lastName,nrPesel,mobileNo,insertDate)
VALUES ('Franciszek', 'Dolas','71567868191','666123685','2018-09-08')
INSERT employees(firstName,lastName,nrPesel,mobileNo,insertDate)
VALUES ('Jerzy', 'Kiler','92123454211','425111253','2019-11-14')
INSERT employees(firstName,lastName,nrPesel,mobileNo,insertDate)
VALUES ('Stefan', 'Siarzewski','77125522331','500111025','2019-12-22')
INSERT employees(firstName,lastName,nrPesel,mobileNo,insertDate)
VALUES ('Mariano', 'Italiano','85112245679','881450600','2019-12-24')

INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('Jan','Kowalski','12345678911','511655018','Poland')
INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('Jakub','Nowak','99112254121','700585282','Poland')
INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('Ferdynand','Lipski','66512456112','453411232','Poland')
INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('Thomas','Muller','85123454311','854123456','Germany')
INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('Ejczu','Ebezoga','95123456789','853456999','Republic of Zimbabwe')
INSERT clients(firstName,lastName,nrPesel,mobileNo,country)
VALUES('enyetuenwuevue','ugbemugbem','54343641232','400235123','Lesotho')

INSERT local_documents(documentId,InsertDate,priceNetto,clientID)
VALUES(1,'2022.01.20',550,1)
INSERT local_documents(documentId,InsertDate,priceNetto,clientID)
VALUES(2,'2021.12.24',324,2)
INSERT local_documents(documentId,InsertDate,tax,priceNetto,clientID)
VALUES(3,'2021.10.11','17',120,3)


INSERT foreign_documents(documentId,insertDate,country,isEuropeanUnion,tax,priceNetto,clientID)	
VALUES(1,'2021.06.05','Germany',1,'17',500,4)

INSERT foreign_documents(documentId,insertDate,country,isEuropeanUnion,tax,priceNetto,clientID)	
VALUES(2,'2021.06.05','Republic of Zimbabwe',0,'32',999,5)

INSERT foreign_documents(documentId,insertDate,country,isEuropeanUnion,tax,priceNetto,clientID)	
VALUES(3,'2021.06.05','Lesotho',0,'15',600,6)

INSERT work_hours(startdate,enddate,hoursAmount,employeeID)
VALUES('2021.10.10','2021.11.10',160,1)
INSERT work_hours(startdate,enddate,hoursAmount,employeeID)
VALUES('2021.10.10','2021.11.10',124,2)
INSERT work_hours(startdate,enddate,hoursAmount,employeeID)
VALUES('2021.10.10','2021.11.10',90,3)
INSERT work_hours(startdate,enddate,hoursAmount,employeeID)
VALUES('2021.10.10','2021.11.10',100,4)
INSERT work_hours(startdate,enddate,hoursAmount,employeeID)
VALUES('2021.10.10','2021.11.10',190,5)

INSERT company_cars(brand,model,vin,RegNo,employeeID)
VALUES('VW','Passat','VW12426460','KR98541',1)
INSERT company_cars(brand,model,vin,RegNo,employeeID)
VALUES('Skoda','Fabia','WSK561223CZ10','KR1LM41',2)
INSERT company_cars(brand,model,vin,RegNo,employeeID)
VALUES('Hyundai','i30','HY124JA465','WI7518J',3)
INSERT company_cars(brand,model,vin,RegNo,employeeID)
VALUES('Opel','Corsa','WO1242GER760','GD85JK1',4)
INSERT company_cars(brand,model,vin,RegNo,employeeID)
VALUES('Citroen','C3','WF585335842FR','KGR88L5',5)

INSERT hardware(brand,model,guaranteeDate,employeeID)
VALUES('ASUS','ExtremePro','2023-11-22',1)
INSERT hardware(brand,model,guaranteeDate,employeeID)
VALUES('ASUS','c11','2024-01-01',2)
INSERT hardware(brand,model,guaranteeDate,employeeID)
VALUES('LG','26G11-AllinOne','2022-06-06',3)
INSERT hardware(brand,model,guaranteeDate,employeeID)
VALUES('ASUS','ExtremePro','2023-11-22',4)
INSERT hardware(brand,model,guaranteeDate,employeeID)
VALUES('Samsung','4278fhsh','2024-05-21',5)
-- Zapytanie o sprzet pracownika z numerem 5
SELECT * FROM hardware
INNER JOIN employees
ON employees.employeeId =hardware.employeeID 
WHERE employees.employeeId = 5;
-- Dokumenty lokalne klienta nr 2
SELECT * FROM local_documents
INNER JOIN clients
ON clients.clientId = local_documents.clientID
WHERE clients.clientId = 2;
-- sprawdzanie jakiej marki samochód oraz sprzêt komputerowy ma pracownik nr 1
SELECT brand
FROM hardware
WHERE employeeID=1
UNION
SELECT brand
FROM company_cars
WHERE employeeID=1

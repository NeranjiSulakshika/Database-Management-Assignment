/****************************DATABASE CREATION************************************/

/* DATABASE CREATION*/

CREATE DATABASE LibraryManagementSystem;
USE LibraryManagementSystem;

/****************************TABLE CREATION************************************/

/*TABLE CREATION BORROWER*/

CREATE TABLE Borrower (
M_ID varchar (4),
M_Fname varchar (15) NOT NULL,
M_Lname varchar (15) NOT NULL,
M_Email varchar (50) NOT NULL,
M_Phone int NOT NULL,
M_NIC varchar (12) NOT NULL,
M_District varchar (20),
M_City varchar (20),
M_Date date NOT NULL,
M_Expiry date NOT NULL,
CONSTRAINT pk_mid PRIMARY KEY (M_ID),
CONSTRAINT uq_mnic UNIQUE (M_NIC),
CONSTRAINT uq_memail UNIQUE (M_Email),
CONSTRAINT uq_mphone UNIQUE (M_Phone),
);

/*TABLE CREATION NEW MEMBER*/

CREATE TABLE new_member (
m_id varchar (4),
m_data varchar (100),
);

/****************************************************************/

SELECT * FROM Borrower;
SELECT * FROM new_member;


/****************************DATA INSERT INTO TABLE************************************/

/*INSERT VALUES*/

INSERT INTO Borrower
VALUES ('M001','Chamoth','Jayasekara','chamothJ@gmail.com','0701234567','20013656969v','COLOMBO','Kesbewa','2001-09-03','2021-09-03');

INSERT INTO Borrower
VALUES ('M002','Neranji','Sulakshika','nera@gmail.com','0701000000','20015000000v','COLOMBO','Kadawatha','2001-01-01','2021-01-01');

INSERT INTO Borrower
VALUES ('M003','Dhanuja','Sigera','dolly@gmail.com','0702000000','20013650001v','COLOMBO','Maharagama','2001-01-01','2021-01-01');

INSERT INTO Borrower
VALUES ('M004','Samadhi','Kaushalya','barrel@gmail.com','0703000000','200150000001','COLOMBO','Kaduwela','2001-01-01','2021-01-01');

INSERT INTO Borrower
VALUES ('M005','Dasith','Rupasingha','dizzy@gmail.com','0704000000','20013650002v','COLOMBO','Kesbewa','2001-01-01','2021-01-01');

INSERT INTO Borrower
VALUES ('M006','Irusha','Samarawikrama','thomas@gmail.com','0705000000','20013650003v','COLOMBO','Maharagama','2000-01-01','2020-01-01');

INSERT INTO Borrower
VALUES ('M007','N','J','god@gmail.com','0706000000','20013650004v','GALLE','Fort','2000-01-01','2020-01-01');

INSERT INTO Borrower
VALUES ('M008','Manoja','Perera','hi@gmail.com','0707000000','20015000002v','','Negombo','2000-01-01','2020-01-01');

INSERT INTO Borrower
VALUES ('M009','Mendika','Gurusingha','sidecut@gmail.com','0708000000','20015000003v','GALLE','','2000-01-01','2020-01-01');

INSERT INTO Borrower
VALUES ('M010','Pasindu','Galtikka','fishbun@gmail.com','0709000000','20015000004v','GALLE','','2000-01-01','2020-01-01');

INSERT INTO Borrower
VALUES ('M011','DB','Epawela','db@gmail.com','0700000000','20013650005v','GALLE','Fort','2002-01-01','2022-01-01');

INSERT INTO Borrower
VALUES ('M012','Mynameis','Library','pusthakaalaya@gmail.com','0700000001','20015000056v','JAFFNA','Pedro','2002-01-01','2022-01-01');

INSERT INTO Borrower
VALUES ('M013','Poth','Books','ilovebooks@gmail.com','0700000002','20015000043v','JAFFNA','Bay','2002-01-01','2022-01-01');

INSERT INTO Borrower
VALUES ('M014','Harry','Potha','abrakadabra@gmail.com','0700000003','20013650045v','JAFFNA','Pedro','2002-01-01','2022-01-01');

INSERT INTO Borrower
VALUES ('M015','Sharuk','Bhan','india@gmail.com','0700000004','20013650032v','GALLE','Negombo','2002-01-01','2022-01-01');

INSERT INTO Borrower
VALUES ('M016','Salt','Pepper','dayya@gmail.com','0700000005','20015000087v','JAFFNA','Bay','1999-01-01','2019-01-01');

INSERT INTO Borrower
VALUES ('M017','Hansel','Gretel','sweety@gmail.com','0700000006','20015000032v','JAFFNA','Pedro','1999-01-01','2019-01-01');

INSERT INTO Borrower
VALUES ('M018','Tom','Jerry','catnmouse@gmail.com','0700000007','20013650083v','JAFFNA','End','1999-01-01','2019-01-01');

INSERT INTO Borrower
VALUES ('M019','NSBM','Malinga','yokerking@gmail.com','0700000008','20013650057v','COLOMBO','Kaduwela','1999-01-01','2019-01-01');

INSERT INTO Borrower
VALUES ('M020','Last','Member','lastemail@gmail.com','0700000009','20015000345v','GALLE','Palace','1999-01-01','2019-01-01');

/****************************TRIGGERS************************************/

/*SQL TRIGGERS FOR MEMBER INSERT*/

CREATE TRIGGER member_insert
ON Borrower
AFTER INSERT
AS
BEGIN
DECLARE @m_id varchar(4)
SELECT @m_id = M_ID from Inserted
INSERT INTO new_member
VALUES (@m_id, 'New Member with Membership ID = ' + CAST (@m_id as varchar (4)) + 'has joined to the library system as at ' + CAST (GETDATE() as varchar(100)));
SELECT * FROM Borrower;
SELECT * FROM new_member;
END

/*SQL TRIGGERS FOR MEMBER DELETE*/

CREATE TRIGGER member_delete
ON Borrower
AFTER DELETE
AS
BEGIN
DECLARE @m_id varchar(4)
SELECT @m_id = M_ID from deleted
INSERT INTO new_member
VALUES (@m_id, 'Member with Membership ID = ' + CAST (@m_id as varchar (4)) + 'has been removed from the library system as at ' + CAST (GETDATE() as varchar(100)));
SELECT * FROM Borrower;
SELECT * FROM new_member;
END

/*SQL TRIGGERS FOR MEMBER UPDATE*/

CREATE TRIGGER member_update
ON Borrower
AFTER UPDATE
AS
BEGIN
DECLARE @m_id varchar(4)
SELECT @m_id = M_ID from inserted
INSERT INTO new_member
VALUES (@m_id, 'Member with Membership ID = ' + CAST (@m_id as varchar (4)) + ' has been updated from the library system as at ' + CAST (GETDATE() as varchar(100)));
SELECT * FROM Borrower;
SELECT * FROM new_member;
END	

/****************************FUNCTIONS************************************/

/*SQL FUNTION TO FIND HOW MANY MEMBERS ARE IN A PARTICULAR DISTRICT*/

CREATE FUNCTION [dbo].[count] (@mdistrict varchar (20))
RETURNS int
AS
BEGIN
DECLARE @count int
SELECT @count = COUNT (M_ID)
FROM Borrower
WHERE M_District = @mdistrict
RETURN @count
END

SELECT [dbo].[count] ('COLOMBO')

/*FUNCTION TO CHECK WHETHER A GIVENS MEMBERS CITY IS NULL OR NOT*/

CREATE FUNCTION checkcity (@mid varchar(4))
RETURNS varchar
AS
BEGIN
DECLARE @city varchar (20)
DECLARE @result varchar(3)
SELECT @city = M_City
FROM Borrower
WHERE M_ID = @mid

IF @city IS NULL
BEGIN
SET @result = 'Yes'
end
Else
begin
set @result = 'No'
END
RETURN @result
END

SELECT dbo.checkcity ('M018')

/****************************PROCEDURES************************************/

/*SQL PROCEDURE TO GET CONTACT INFORMATION OF A GIVEN MEMBER*/

CREATE Procedure membercontact
(@mid varchar(4))
AS
BEGIN
SELECT M_Fname, M_Email, M_Phone
FROM Borrower
WHERE M_ID = @mid
END

EXEC membercontact M006

/*SQL PROCEDURE TO GET MEMBERSHIP INFORMATION OF A GIVEN MEMBER*/

CREATE Procedure membershipdetails
(@mid varchar(4))
AS
BEGIN
SELECT M_ID, M_Expiry, M_Date
FROM Borrower
WHERE M_ID = @mid
END

EXEC membershipdetails M001

/****************************VEIWS************************************/

/*SQL VIEW TO GET ALL THE MEMBERS LOCATIONS*/

GO
CREATE VIEW memberlocation AS
SELECT M_ID, M_District, M_City
FROM Borrower

SELECT * FROM memberlocation

/*SQL VIEW TO FIND OUT THE MEMBERS WHO HAS BORROWED BOOKS*/

CREATE VIEW bookborrowed 
AS 
SELECT TOP 5 
M_ID, M_Fname, i.B_ISBN
FROM [dbo].Borrower AS b
INNER JOIN dbo.IssueInfo AS i 
ON i.Member_ID = b.M_ID
ORDER BY M_ID ASC

SELECT * FROM bookborrowed



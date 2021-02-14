CREATE DATABASE Staff;

USE Staff;

CREATE TABLE StaffTable(
FirstName varchar(50) NOT NULL, 
LastName varchar(50) NOT NULL,
Contact int NOT NULL,
Email varchar(30),
StaffID int IDENTITY(1,1) NOT NULL,
StaffRole varchar(20) NOT NULL,
Joined_Date date NOT NULL,
CONSTRAINT pk_staffid PRIMARY KEY (StaffID),
CONSTRAINT u_email UNIQUE (Email),
CONSTRAINT u_fullname UNIQUE (FirstName,LastName)
);

CREATE TABLE newmembers(
Staff_Id int NOT NULL,
joineddate date NOT NULL);  


CREATE TABLE AuthSysTable(
StaffID INT NOT NULL,
Username varchar(20) UNIQUE NOT NULL,
Password varchar(20) UNIQUE NOT NULL,
);

SELECT * FROM StaffTable;

SELECT * FROM AuthSysTable;

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Dasitha','Samarasinghe','0772899112','dsamare21@gmail.com','Bookkeeper','2002-01-19');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Shevon','Marasinghe','0772431132','shemara67@gmail.com','Cleaner','2005-03-15');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Chamodh','Jayasekara','0772569112','chamo41@gmail.com','Bookkeeper','2005-08-23');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Nethmi','Sulakshika','0772899432','N5sulakshika23@gmail.com','Cleaner','2006-07-26');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Dhanuja','Sigera','0776783242','djvandiesl@yahoo.com','Ledger Holder','2008-12-12');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Kevin','Koththigoda','0768392313','kevinkoththi90@gmail.com','Bookkeeper','2009-01-02');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Dhanuska','Samarasinghe','0772892312','danusamare12@gmail.com','Bookkeeper','2009-09-18');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Pathme','Sirisenage','0777829112','pathme23@gmail.com','Guard','2009-09-12');

INSERT INTO StaffTable (FirstName,LastName,Contact,StaffRole,Joined_Date) VALUES ('Romesh','Udana','0722499112','Cleaner','2012-03-12');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Rohitha','Gunaratne','0732456722','rohithagune32@yahoo.com','Guard','2014-02-23');

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Vindya','Ravindi','0732499112','vini45@yahoo.com','Admin','2013-02-24');

//SHOW DETAILS OF ADMINS WITHOUT CREDENTIALS

CREATE VIEW [Admin_INFO] AS
SELECT FirstName, LastName, StaffID, StaffRole, Contact
FROM StaffTable
WHERE StaffRole='Admin';

SELECT * from Admin_INFO;

// SHOW DETAILS OF old members

CREATE VIEW [Old_Members] AS
SELECT FirstName, LastName, StaffID, StaffRole, Contact, Joined_Date
FROM StaffTable
where Joined_Date<'2019-01-01';
 
SELECT * FROM Old_Members

INSERT INTO AuthSysTable (StaffID,Username,Password) VALUES ('11','Nethi','abc123');


INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Vindi','Narandhi','0747499154','never23@yahoo.com','Bookledger','2018-05-23');

// CREATE DATE INSERT INTO newmembers  TABLE


CREATE TRIGGER Date_Insert
ON StaffTable 
AFTER INSERT
AS
BEGIN
DECLARE @id INT
SELECT @id = StaffID from inserted
INSERT INTO newmembers VALUES (@id, CAST(GETDATE() as date))
SELECT * FROM newmembers
SELECT * FROM StaffTable
END

INSERT INTO StaffTable (FirstName,LastName,Contact,Email,StaffRole,Joined_Date) VALUES ('Abdul','Rashid','0732349112','rashid321@yahoo.com','Bookledger',CAST(GETDATE() as date));

SELECT*FROM newmembers


//CREATING A FUNCTION TO SEEK FULL NAME BY STAFFID

CREATE FUNCTION findname (@id int)
 RETURNS VARCHAR (50)
AS
BEGIN 
 DECLARE @name VARCHAR(50)
 SELECT @name = CONCAT(FirstName,' ',LastName)
 FROM StaffTable
 WHERE StaffID = @id
 RETURN @name
END

SELECT dbo.findname(5) AS [Staff Member Name]

// SHOW DETAILS OF ALL BOOKKEEPERS

CREATE PROCEDURE listbookkeepers
AS SELECT * FROM StaffTable
WHERE StaffRole = 'Bookkeeper'
GO

EXEC listbookkeepers


// SHOW ADMIN DETAILS WITH CREDENTIALS

CREATE PROCEDURE admindetailswithcredentials
AS
SELECT * FROM StaffTable AS S
JOIN AuthSysTable AS A
ON S.StaffID = A.StaffID
GO

EXEC admindetailswithcredentials

CREATE TRIGGER updatestaff
ON StaffTable
AFTER UPDATE 
AS
BEGIN
SELECT * FROM StaffTable
END

UPDATE StaffTable
SET StaffRole = 'Cleaner'
WHERE StaffID = 10 ;

CREATE TRIGGER deletestaff
ON StaffTable
AFTER DELETE  
AS
BEGIN
SELECT * FROM StaffTable
END

DELETE FROM StaffTable where StaffID = 11





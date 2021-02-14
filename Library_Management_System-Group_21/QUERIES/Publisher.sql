
CREATE DATABASE Library;


USE Library;

CREATE TABLE Book(
ISBN varchar(5), 
B_Name varchar (50) NOT NULL,
B_Author varchar (50) NOT NULL,
B_PublishedDate varchar (5),
B_Title varchar (50),                                 
B_Category varchar (50) NOT NULL,
CONSTRAINT Pk_isbn PRIMARY KEY (ISBN),
);



CREATE TABLE Publisher (
	Pub_ID varchar (5),
	Pub_Name varchar (50),
	Published_BookID varchar (5) FOREIGN KEY (Published_BookID) REFERENCES dbo.Book (ISBN),     /* ISBN USED BY BOOK TABLE TO CREATE A FOREIGN KEY */
	Pub_Country varchar (50),
	Pub_City varchar (50) DEFAULT 'Colombo',                                                  /* DEFAULT CONSTRAINT USED TO FILL THE ROW AUTOMATICALLY */
	Pub_Date date,
	Pub_Contact char (10),
	Pub_Email varchar (50),
	CONSTRAINT pk_id PRIMARY KEY (Pub_ID),                                                    /* PRIMARY KEY OF THE TABLE */
	CONSTRAINT uk_cntNo UNIQUE (Pub_Contact),                                                 /* UNIQUE CONSTRAINT IS USED AS CONTACT NUMBERS DIFFER */
);


SELECT * FROM Book;            /* DISPLAYS THE BOOK TABLE */

SELECT * FROM Publisher;       /* DISPLAYS THE PUBLISHER TABLE */





INSERT INTO Book
Values('B001', 'Harry Potter ', 'J. K. Rowling','1997', 'and the Philosophers Stone', 'Novel');

INSERT INTO Book
Values('B002', 'Harry Potter', 'J. K. Rowling', '2007', 'and the Deathly Hallows', 'Novel');

INSERT INTO Book
Values('B003', 'Harry Potter', 'J. K. Rowling', '2016', 'and the Cursed Child', 'Novel');

INSERT INTO Book
Values('B004', 'Harry Potter', 'J. K. Rowling', '2000', 'and the Goblet of Fire ', 'Novel');

INSERT INTO Book
Values('B005', 'Harry Potter', 'J. K. Rowling', '2003', 'and the Order of the Phoenix ', 'Novel');

INSERT INTO Book
Values('B006', 'Harry Potter', 'J. K. Rowling', '2003', 'and the Chamber of Secrets ', 'Novel');

INSERT INTO Book
Values('B007', 'Harry Potter', 'J. K. Rowling', '1999', 'and the Prisoner of Azkaban ', 'Novel');

INSERT INTO Book
Values('B008', 'Cinderella', 'Daisy Fisher', '1981', '', 'Fairy tale');

INSERT INTO Book
Values('B009', 'Dracula', 'Bram Stoker', '1897', '', 'Novel');

INSERT INTO Book
Values('B010', 'House of leaves', 'Mark Z. Danielewski', '2000', '', 'Novel');

INSERT INTO Book
Values('B011', 'Wonder Woman:', 'Leigh Bardugo', '2017', 'Warbringer', 'Fiction');

INSERT INTO Book
Values('B012', 'The Chronicles', 'C.S.Lewis', '1950', 'Narnia', 'Novel');

INSERT INTO Book
Values('B013', 'Twilight', 'Stephenie Meyer', '2006', 'New moon', 'Novel');



INSERT INTO Publisher 
VALUES ('1000' , 'Bloomsbury Publishing' , 'B001' , 'United Kingdom' , 'London' , '1997/6/26' , '0112445871' , 'bloomsbury.publishing@yahoo.com');

INSERT INTO Publisher 
VALUES ('1001' , 'United Book Distributors' , 'B002' , 'Australia' , 'Sydney' , '1998/8/15' , '0225345871' , 'uniteddistributors000@gmail.com');

INSERT INTO Publisher 
VALUES ('1002' , 'Macmillans' , 'B003' , 'United States' , 'New York' , '1999/5/02' , '0557484871' , 'macmillans123@gmail.com');

INSERT INTO Publisher 
VALUES ('1003' , 'Penguin books' , 'B004' , 'United States' , ' ' , '2000/7/20' , '0118545871' , 'penguinbooks@ymail.com');

INSERT INTO Publisher 
VALUES ('1004' , 'Scolastic press' , 'B005' , 'United Kingdom' , 'Texas' , '2003/1/26' , '0715224871' , 'scolasticpress123@gmail.com');

INSERT INTO Publisher 
VALUES ('1005' , 'VI Publishers' , 'B006' , 'Australia' , 'Perth' , '2005/5/14' , '0524745871' , 'vipublishers@gmail.com');

INSERT INTO Publisher 
VALUES ('1006' , 'Aspen Publishers' , 'B007' , 'United	States' , ' ' , '2003/1/26' , '0715445871' , 'aspenpublishers@hotmail.com');

INSERT INTO Publisher 
VALUES ('1007' , 'Blue Whale Press' , 'B008' , 'United States' , 'New York' , '2007/2/15' , '0112857871' , 'bluewhales@gmail.com');

INSERT INTO Publisher 
VALUES ('1008' , 'Scribner press' , 'B009' , 'United States' , 'Chicago' , '1997/1/16' , '0047845871' , 'scibnerpress@ymail.com');

INSERT INTO Publisher 
VALUES ('1009' , 'Archid constable and company' , 'B010' , 'United Kingdom' , 'Bristol' , '1897/6/26' , '0769874471' , 'archidconstablecompany@gmail.com');

INSERT INTO Publisher 
VALUES ('1010' , 'Pantheon house' , 'B011' , 'United Kingdom' , ' ' , '2000/3/07' , '0114785371' , 'pantheonhouse123@hotmail.com');

INSERT INTO Publisher 
VALUES ('1011' , 'DC Comics' , 'B012' , ' ' , ' ' , ' ' , ' 022489594' , 'dccomics@yahoo.com');

INSERT INTO Publisher 
VALUES ('1012' , 'Simon & Shuster' , 'B013' , 'United Kingdom' , 'Cardiff' , '2014/4/15' , '0112478871' , 'simon&shutter2gmail.com');


SELECT * FROM Book;

SELECT * FROM Publisher;             /* DISPLAYS THE PUBLISHER TABLE WITH
										THE RECORDS INSERTED */




/////////////////////////////////********************************************* VIEWSS *********************************///////////////////////////////

CREATE VIEW View_Publisher
AS
	SELECT *                   /* CREATION OF A VIEW TO FIND THE PUBLISHER BY THE Pub_ID */
	FROM Publisher
	WHERE Pub_ID = '1005';


SELECT * FROM View_Publisher;






CREATE VIEW view_PubCountry_UK
AS 
	SELECT *                          /* A VIEW TO FIND THE PUBLISHER FROM THE COUNTRY (e.g. UK) */
	FROM Publisher
	WHERE Pub_Country = 'United kingdom';


SELECT * FROM view_PubCountry_UK;



UPDATE view_PubCountry_UK 
SET Pub_City = 'London' 
WHERE Pub_ID = 1009;



SELECT * FROM view_PubCountry_UK;




CREATE VIEW view_toFindBnameAndBauthor
AS

	SELECT Pub_ID , Pub_Name , b.ISBN , B_Name , B_Author , Pub_Date
	FROM Book b , Publisher p
	WHERE b.ISBN = p.Published_BookID;



SELECT * FROM view_toFindBnameAndBauthor;


 ////////////////******************************** FUNCTIONS ******************************////////////////////////////

CREATE FUNCTION Pub_Details (@id varchar(5))
	RETURNS TABLE
AS
RETURN 
	(SELECT Pub_ID , Pub_Name, Pub_Contact
	FROM Publisher 
	WHERE Pub_ID = @id)

SELECT * FROM Pub_Details ('1005');


CREATE FUNCTION Pub_Country (@PCountry varchar (50))
	RETURNS TABLE 
AS 
RETURN 
	(SELECT Pub_ID , Pub_Name , Published_BookID , Pub_Contact , Pub_Country , Pub_Date 
	FROM Publisher 
	WHERE Pub_Country = @PCountry);

SELECT * FROM Pub_Country('United States');



/////////////////////********************** TRIGGERS *************************************/////////////////////////

//** CAN ALSO BE USED TO CREATE DEFAULT VALUE OF COLOMBO***//

CREATE TRIGGER Pub_Insert 
ON Publisher 
FOR INSERT
AS 
	SELECT Pub_ID , Pub_Name , Pub_Country 
	FROM Publisher;

INSERT INTO Publisher ( Pub_ID , Pub_Name , Pub_Country )  
VALUES ('1013' , 'Sam publishers' , 'India');

INSERT INTO Publisher ( Pub_ID , Pub_Name , Pub_Country  , Pub_Contact)  
VALUES ('1015' , 'DI publishers' , 'Sri Lanka' , '033145554');

SELECT * FROM Publisher;


CREATE TRIGGER Pub_Update 
ON Publisher 
AFTER UPDATE 
AS 
	SELECT Pub_ID , Pub_Name , Pub_Country 
	FROM Publisher;

UPDATE Publisher 
SET Pub_Country = 'Sri Lanka'
WHERE Pub_ID = '1013';

DROP TRIGGER IF EXISTS Pub_Insert;
//////*** trigger to get the date ***********//////

CREATE TRIGGER date_Update 
ON Publisher 
AFTER UPDATE 
AS                           /* TRIGGER TO GET THE CURRENT DATE */
BEGIN
	set nocount on;
	UPDATE publisher set Pub_Date = getdate()
	FROM Publisher p 
	INNER JOIN inserted i on p.Pub_ID = i.Pub_ID
	AND i.Pub_Country = 'Approved'
END 
GO 

UPDATE Publisher set Pub_Country = 'Approved'
WHERE Pub_ID = 1011
GO

SELECT * FROM Publisher;


///////////////////////******************************  STORED PROCEDURE **************************************//////////////////////

CREATE PROCEDURE find_publisher
	@id varchar (5)
AS 
	SELECT Pub_ID , Pub_Name , Pub_Contact 
	FROM Publisher 
	WHERE Pub_ID = @id

EXEC find_publisher '1002';
EXEC find_publisher '1009';



CREATE PROCEDURE noOfPublishers
@Pub_ID varchar (5) 
AS 
BEGIN
	DECLARE @totpublishers int 
	SELECT @totpublishers = count(Pub_ID) FROM Publisher 
RETURN @totpublishers
END 

DECLARE @pubValue int 
EXEC @pubValue = noOfPublishers ''
PRINT @pubValue

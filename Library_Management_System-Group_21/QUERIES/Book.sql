CREATE DATABASE Library_Book1;

USE Library_Book1;

/*************TABLE CREATION*************/

CREATE TABLE Book(
ISBN varchar(5), 
B_Name varchar (50) NOT NULL,
B_Author varchar (50) NOT NULL,
B_PublishedDate DATE,
B_Title varchar (50),
B_Category varchar (50) NOT NULL,
CONSTRAINT Pk_isbn PRIMARY KEY (ISBN),
);

SELECT * FROM Book;

/****************TABLE INSERTION*************/

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

INSERT INTO Book
Values('B014', 'A Promised Land', 'Barack Obama', '2020', '', 'Autobiography');

INSERT INTO Book
Values('B015', 'Goosebumps', 'R. L. Stine', '1993', 'The Haunted Mask', 'Horror fiction');

INSERT INTO Book
Values('B016', 'Goosebumps', 'R. L. Stine', '1992', 'Welcome to Dead House', 'Horror fiction');

INSERT INTO Book
Values('B017', 'Goosebumps', 'R. L. Stine', '1993', 'Night of the Living Dummy', 'Horror fiction');

INSERT INTO Book
Values('B018', 'White House:', 'Amy Bloom', '2018', 'A Novel', 'Historical fiction');

INSERT INTO Book
Values('B019', 'Twilight', 'Stephenie Meyer', '2007', 'Eclipse', 'Novel');

INSERT INTO Book
Values('B020', 'Twilight', 'Stephenie Meyer', '2008', 'Breaking Dawn', 'Novel');

SELECT * FROM Book;


/*************TRIGGERS*************/

CREATE TRIGGER Book_Insert
ON Book
AFTER INSERT
AS
    SELECT ISBN, B_Name, B_Author, B_Category
	FROM Book;
	INSERT INTO Book(ISBN, B_Name, B_Author, B_Category)
	VALUES('B015', 'Goosebumps', 'R.L.Stine', 'Horro fiction');

	SELECT * FROM Book;

	

	DROP TRIGGER IF EXISTS Book_Insert;


CREATE TRIGGER BookDate_Update
ON Book
AFTER UPDATE
AS
 BEGIN
     set nocount on;
	 UPDATE book set B_PublishedDate = getdate()
	 FROM Book b
	 INNER JOIN inserted i on b.ISBN = b.ISBN
	 AND i.B_Name = 'Approved'
 END
 GO

 UPDATE Book set B_Name = 'Approved'
 WHERE ISBN = 'B015'
 GO

 SELECT * FROM Book

 DROP TRIGGER IF EXISTS BookDate_Update;


 /*****************VIEWS****************/

CREATE VIEW View_Book
AS 
  SELECT * FROM Book
  WHERE ISBN = 'B015';

  SELECT * FROM View_Book;

CREATE VIEW View_Book_Novel
AS
  SELECT ISBN, B_Name, B_Title, B_Author
  FROM Book
  WHERE B_Category = 'Novel';

  SELECT * FROM View_Book_Novel;


  /****************PROCEDURES****************/
CREATE PROCEDURE find_book
  @id varchar (5)
AS 
    SELECT ISBN, B_Name, B_Title
	FROM Book
	WHERE ISBN = @id      /****Create****/

EXEC find_book 'B016';    /****Execute***/
EXEC find_book 'B017';


CREATE PROCEDURE noOfBOOK
@ISBN varchar(5)
AS
BEGIN
   DECLARE @totbook int
   SELECT @totbook = count(ISBN)FROM
   Book
   RETURN @totbook
   END

   DECLARE @b_value int 
   EXEC @b_value = noOfBOOK
   PRINT @b_value 

/***********************FUNCTIONS***********************/

CREATE FUNCTION B_Category(@BCategory varchar (50))
RETURNS TABLE
AS
RETURN
  (SELECT ISBN, B_Name, B_PublishedDate, B_Title
  FROM Book
  WHERE B_Category = @BCategory);

  SELECT * FROM B_Category('Novel');

CREATE FUNCTION B_Details (@id varchar(5))
RETURNS TABLE 
AS
RETURN
  (SELECT ISBN, B_Name, B_Author
  FROM Book
  WHERE ISBN = @id)

  SELECT * FROM B_Details ('B016');
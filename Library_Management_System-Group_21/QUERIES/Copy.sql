


			/*****************CONSTRAINTS*****************/


CREATE TABLE Copy
(		
		Copy_ISBN varchar(5) NOT NULL,
		CopyNo varchar(10),
		Price float NOT NULL,
		CONSTRAINT pk_CopyNo PRIMARY KEY (CopyNo),		/*PRIMARY KEY*/
		CONSTRAINT fk_ISBN FOREIGN KEY 
					(Copy_ISBN) REFERENCES Book(ISBN)	/*FOREIGN KEY*/	
);

SELECT * FROM Copy;
		
		
/*INSERTED*/
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B001', 'A01', 1050.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B002', 'B01', 1000.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B003', 'C01', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B003', 'C02', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B003', 'C03', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B004', 'D01', 1750.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B005', 'E01', 1975.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B005', 'E02', 1975.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B005', 'E03', 1975.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B006', 'F01', 1350.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B006', 'F02', 1350.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B007', 'G01', 1000.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B007', 'G02', 1000.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B007', 'G03', 1000.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B007', 'G04', 1000.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B008', 'H01', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B008', 'H02', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B009', 'I01', 1350.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B010', 'J01', 1750.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B011', 'K01', 1975.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B012', 'L01', 1050.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B013', 'M01', 1100.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B014', 'N01', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B014', 'N02', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B014', 'N03', 1500.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B015', 'O01', 1750.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B016', 'P01', 1550.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B016', 'P02', 1550.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B016', 'P03', 1550.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B017', 'Q01', 1350.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B017', 'Q02', 1350.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B018', 'R01', 1490.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B018', 'R02', 1490.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B018', 'R03', 1490.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B018', 'R04', 1490.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B019', 'S01', 1630.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B019', 'S02', 1630.00);
Insert into Copy(Copy_ISBN, CopyNo, Price) VALUES ('B020', 'T01', 1350.00);

SELECT * FROM Copy;



			/*****************TRIGGERS*****************/


		/* AFTER UPDATE */
CREATE TRIGGER AfterUPDATETrigger on [Copy]
FOR UPDATE 
AS DECLARE @CopyNo varchar(10),
		   @Price float;

SELECT @CopyNo = ins.CopyNo FROM INSERTED ins;
SELECT @Price = ins.Price FROM INSERTED ins;

/*After..*/
SELECT * FROM Copy WHERE CopyNo = 'E01';

UPDATE [Copy]
	SET [Price] = 1950.00
	WHERE CopyNo = 'E01'

SELECT * FROM Copy WHERE Copy_ISBN= 'B005';




/* AFTER DELETE */

CREATE TRIGGER AfterDELETETrigger on [Copy]
FOR DELETE 
AS DECLARE @CopyNo varchar(10);

SELECT @CopyNo = del.CopyNo FROM DELETED del;

SELECT * FROM Copy WHERE Copy_ISBN= 'B006';

/*After..*/
DELETE FROM [Copy]
	WHERE [CopyNo] = 'F01' 

SELECT * FROM Copy WHERE Copy_ISBN= 'B006';






			/*****************PROCEDURES*****************/


/*SELECT STORED PROCEDURE*/

CREATE PROCEDURE SelectStoredProcedureCopy
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 15 [Copy_ISBN],
                  [CopyNo],
                  [Price] AS [Price(Rs.)]
	FROM [Copy]
	ORDER BY [Price] ASC

	SELECT TOP 15 [Copy_ISBN],
                  [CopyNo],
                  [Price] AS [Price(Rs.)]
	FROM [Copy]
	ORDER BY [Price] DESC
	
	SELECT TOP 10 [Copy_ISBN],
                  [CopyNo]
	FROM [Copy]
	ORDER BY [CopyNo] ASC

	SELECT TOP 5 [Copy_ISBN],
                  [CopyNo]
	FROM [Copy]
	ORDER BY [CopyNo] DESC

	SELECT TOP 15 [Copy_ISBN],
                  [CopyNo],
                  [Price] AS [Price(Rs.)]
	FROM [Copy]
	ORDER BY [Copy_ISBN] ASC

	SELECT TOP 10 [Copy_ISBN],
				  [CopyNo],
                  [Price] AS [Price(Rs.)]
	FROM [Copy]
	ORDER BY [Copy_ISBN] DESC
END

EXEC [dbo].[SelectStoredProcedureCopy]



/*UPDATE STORED PROCEDURE*/

CREATE PROCEDURE UpdateStoredProcedureCopy
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [Copy] SET [Price] = 1115.00
        WHERE [CopyNo] = 'A01'	 
END

SELECT * FROM Copy WHERE CopyNo= 'A01';

EXEC [dbo].[UpdateStoredProcedureCopy]

SELECT [Copy_ISBN],
       [CopyNo],
       [Price] AS [Price(Rs.)]
  FROM [Copy]
  ORDER BY [Price] DESC





  			/*****************VIEWS*****************/

/*CREATE VIEW*/

CREATE VIEW CopyViewbyQuery
AS
SELECT TOP 10 [Copy_ISBN],
			  CopyNo,
			  Book.B_Name,
			  Price AS [Price(Rs.)]
FROM  dbo.Copy 
   INNER JOIN
      dbo.[Book] ON 
        Copy.[Copy_ISBN] = Book.ISBN 
ORDER BY Copy.[Copy_ISBN] DESC

SELECT * FROM [dbo].[CopyViewbyQuery]



/*CREATE VIEW - Price*/

CREATE VIEW PriceView
AS
SELECT TOP 15 [Copy_ISBN],
			  CopyNo,
			  B.B_Name,
			  Price AS [Price(Rs.)]
FROM  dbo.Copy
   INNER JOIN
      dbo.[Book] AS B ON 
        Copy.[Copy_ISBN] = B.ISBN
		WHERE Copy.Price = 1000

SELECT * FROM [dbo].[PriceView]





  			/*****************FUNCTIONS*****************/


  /*Create SQL Scalar Function*/

CREATE FUNCTION SummationOfBookPrice (@Copy_ISBN int)
  RETURNS FLOAT
  AS
    BEGIN 
       RETURN (SELECT  SUM([Price]) FROM [Copy]
	        WHERE Copy.[Copy_ISBN] = @Copy_ISBN)
END

SELECT [Copy_ISBN],
      SUM([Price]) as [Total Price of the Books(Rs.)]
  FROM [Copy]
  group by [Copy_ISBN]




 /*SQL Inline Function with Parameters*/

CREATE FUNCTION LibraryCopy (@copyNo VARCHAR(10))
  RETURNS TABLE
  AS
     RETURN (
		SELECT	[CopyNo],
				[Copy_ISBN],
				B.B_Name AS BookName,
				[Price] AS [Price(Rs.)]
		FROM [Copy]
		INNER JOIN 
		Book AS B ON
		  B.[ISBN] = [Copy].Copy_ISBN
		WHERE [CopyNo] = @copyNo
		)

SELECT * FROM [dbo].[LibraryCopy] ('A01')



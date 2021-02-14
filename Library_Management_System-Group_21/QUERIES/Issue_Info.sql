
/*****************CONSTRAINTS*****************/




CREATE TABLE IssueInfo
(
IssueNo int IDENTITY(1,1), /*AUTO INCREMENT*/
B_ISBN varchar(5) NOT NULL FOREIGN KEY (B_ISBN) REFERENCES Book(ISBN), /*FOREIGN KEY*/
CopyNo varchar(10) NOT NULL,
Member_ID varchar(4) NOT NULL FOREIGN KEY (Member_ID) REFERENCES Borrower(M_ID), /*FOREIGN KEY*/
Fine float,
IssueDate DATE NOT NULL,
ReturnDate DATE NOT NULL,
CONSTRAINT pk_IssueNo PRIMARY KEY (IssueNo), /*PRIMARY KEY*/
CONSTRAINT fk_CopyNo FOREIGN KEY
(CopyNo) REFERENCES Copy(CopyNo), /*FOREIGN KEY*/
);



SELECT * FROM IssueInfo;






/*****************INSERT SAMPLE DATA*****************/



INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B001', 'A01', 'M001', '10.00', '2020.12.18', '2021.01.01');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B002', 'B01', 'M002', '10.00', '2020.12.18', '2021.01.01');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B003', 'C01', 'M003', '0.00', '2020.12.22', '2021.01.05');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B008', 'H01', 'M006', '', '2020.12.23', '2021.01.06');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B006', 'F02', 'M014', '10.00', '2020.12.23', '2021.01.06');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B010', 'J01', 'M019', '', '2020.12.24', '2021.01.07');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B004', 'D01', 'M010', '', '2020.12.25', '2021.01.08');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B005', 'E01', 'M017', '', '2020.12.27', '2021.01.10');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B007', 'G02', 'M020', '', '2020.12.27', '2021.01.10');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B009', 'I01', 'M004', '', '2020.12.31', '2021.01.14');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B011', 'K01', 'M008', '', '2021.01.01', '2021.01.15');

INSERT INTO IssueInfo (B_ISBN, CopyNo, Member_ID, Fine, IssueDate, ReturnDate)
VALUES ('B013', 'M01', 'M005', '', '2021.01.01', '2021.01.15');

SELECT * FROM IssueInfo;




/*****************TRIGGERS*****************/

/* AFTER UPDATE */

CREATE TRIGGER AfterUPDATETriggerIssueInfo on [IssueInfo]
FOR UPDATE
AS DECLARE @IssueNo int,
@ReturnDate date;

SELECT @IssueNo = ins.IssueNo FROM INSERTED ins;
SELECT @ReturnDate = ins.ReturnDate FROM INSERTED ins;


/*Execute..*/
UPDATE [IssueInfo]
SET [ReturnDate] = '2021.01.02'
WHERE IssueNo = 1

SELECT * FROM IssueInfo;




/* AFTER DELETE */

CREATE TRIGGER AfterDELETETriggerIssueInfo on [IssueInfo]
FOR DELETE
AS DECLARE @IssueNo int;

SELECT @IssueNo = del.IssueNo FROM DELETED del;

/*Execute..*/
DELETE FROM [IssueInfo]
WHERE [IssueNo] = 3

SELECT * FROM IssueInfo;





/*****************PROCEDURES*****************/

/*SELECT STORED PROCEDURE*/

CREATE PROCEDURE SelectStoredProcedureIssueInfo
AS
BEGIN
SET NOCOUNT ON;
SELECT TOP 10 [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [B_ISBN] ASC

SELECT TOP 10 [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [CopyNo] DESC

SELECT TOP 10 [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [Member_ID] ASC

SELECT TOP 10 [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [IssueDate] DESC

SELECT TOP 10 [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [ReturnDate] ASC
END

EXEC [dbo].[SelectStoredProcedureIssueInfo]




/*UPDATE STORED PROCEDURE*/

CREATE PROCEDURE UpdateStoredProcedureIssueInfo
AS
BEGIN
SET NOCOUNT ON;
UPDATE [IssueInfo] SET [IssueDate] = '2020.12.17'
WHERE [CopyNo] = 'A01'
END

SELECT [IssueNo],
[B_ISBN],
[CopyNo],
[Member_ID],
[Fine] AS [Fine (Rs.)],
[IssueDate],
[ReturnDate]
FROM [IssueInfo]
ORDER BY [Member_ID] ASC





/*****************VIEWS*****************/

/*CREATE VIEW - Issued Book Informations*/

CREATE VIEW CreateIssueInfoMemberView
AS
SELECT TOP 10
Member_ID,
B.M_Fname AS [Member Name],
B_ISBN,
CopyNo,
Fine AS [Fine(Rs.)]
FROM dbo.IssueInfo AS Iss
INNER JOIN
dbo.[Borrower] AS B ON
B.M_ID = Iss.Member_ID
ORDER BY Member_ID DESC

SELECT * FROM [dbo].[CreateIssueInfoMemberView]




/*CREATE VIEW - View Fine Details*/

CREATE VIEW CreateFineView
AS
SELECT TOP 10 B_ISBN,
Iss.CopyNo,
Member_ID,
Borr.M_Fname AS [Member Name],
Fine AS [Fine (Rs.)]
FROM dbo.IssueInfo AS Iss
INNER JOIN
dbo.[Borrower] AS Borr ON
Iss.Member_ID = Borr.M_ID
WHERE Fine <= 10.00

SELECT * FROM [dbo].[CreateFineView]





/*****************FUNCTIONS*****************/

/*Create SQL Scalar Function - Get SUM of the fines*/

CREATE FUNCTION SummationOfFine (@Member_ID varchar(4))
RETURNS FLOAT
AS
BEGIN
RETURN (SELECT SUM([Fine]) FROM [IssueInfo]
WHERE [Member_ID] = @Member_ID)
END

SELECT [Member_ID],
SUM([Fine]) as [Total Fine of the Books (Rs.)]
FROM [IssueInfo]
group by [Member_ID]




/*Create SQL Scalar Function - Check Fine */

CREATE FUNCTION CheckFine(@MemberId varchar(4))
RETURNS char(8)
AS
BEGIN
DECLARE @fine float
DECLARE @result char(30)
SELECT @fine = Fine
FROM IssueInfo
WHERE Member_ID = @MemberId
IF @fine = 0
BEGIN
SET @result = ('YES') /*If the fine is null*/
END;
ELSE
BEGIN
SET @result = ('NO') /*If the fine is not null*/
END;
RETURN @result
END;



/* Checking if these members have book fine null or not*/



SELECT dbo.CheckFine('M002')
SELECT dbo.CheckFine('M004')
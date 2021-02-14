CREATE TABLE [dbo].[BOOK]
(
	[ISBN] INT NOT NULL PRIMARY KEY, 
    [Book_Name] VARCHAR(50) NOT NULL, 
    [Book_Title] VARCHAR(50) NULL, 
    [Book_Author] VARCHAR(50) NULL, 
    [Book_Publication] VARCHAR(50) NULL, 
    [Book_Purchase_Date] DATE NOT NULL, 
    [Book_Qty] INT NOT NULL
)

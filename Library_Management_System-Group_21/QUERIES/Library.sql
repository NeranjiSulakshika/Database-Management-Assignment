CREATE TABLE library (libcode char (20) not null,
LibraryType varchar (50),
BranchName varchar (50) not null,
BranchType varchar(50) not null,
City varchar (20) not null,
LibNumber varchar (20) not null,
CopyNumber varchar (20) not null,
CONSTRAINT pk_code PRIMARY KEY (libcode),
CONSTRAINT uk_address UNIQUE (Libnumber),);


SELECT * FROM library; 
insert into library values ('003' , 'Branch','NSBM','school','homagama', '31/45' ,'03')
insert into library values ('002' , 'Branch','IBT','school','colombo', '11/45' ,'05')
insert into library values ('001' , 'main','nex','public','colombo', '12/45' ,'63')
insert into library values ('004' , 'branch','nex','public','kandy', '15/45' ,'33')
insert into library values ('005' , 'main','NSBM','school','colombo', '18/45' ,'43')
insert into library values ('006' , 'branch','norton','private','colombo', '10/45' ,'72')
insert into library values ('007' , 'branch','leeds','school','Galle', '60/45' ,'92')
insert into library values ('008' , 'main','weed','private','colombo', '05/45' ,'70')
insert into library values ('009' , 'branch','learn it','public','Thalawathugoda', '54/45' ,'32')
insert into library values ('010' , 'branch','oxford','public','Thalawathugoda', '04/45' ,'27')
insert into library values ('011' , 'branch','Gateway','school','Kandy', '99/045' ,'79')
insert into library values ('012' , 'main','Gateway','school','colombo', '97/405' ,'90')
insert into library values ('013' , 'branch','Harward','school','colombo', '97/415' ,'99')
insert into library values ('014' , 'branch','lions','private','colombo', '970/415' ,'19')
insert into library values ('015' , 'main','jupiter','private','Jaffna', 'e70/415' ,'09')
insert into library values ('016' , 'branch','jupiter','private','kataragama', '78/15' ,'91')
insert into library values ('016' , 'branch','jupiter','private','kataragama', '78/15' ,'91')
insert into library values ('017' , 'branch','jupiter','private','ragama', '78/157' ,'89')
insert into library values ('018' , 'branch','jupiter','private','colombo', '786/157' ,'69')
insert into library values ('019' , 'main','Thanos','public','colombo', '786/107' ,'49')
insert into library values ('020' , 'branch','Thanos','public','hikkaduwa', '06/07' ,'67')

/******triggers*****/
create trigger library_insert
on library


for insert
  AS  
    SELECT libcode,libraryType,BranchName,BranchType,City,LibNumber,CopyNumber
    from library

 

create trigger library_update
on library
for update 
as  
    SELECT libcode,libraryType,BranchName,BranchType,City,LibNumber,CopyNumber
    from library
 

/**** Function ****/
 
 CREATE FUNCTION [dbo].[cities] 
(@common varchar (50))
RETURNS int
 AS 
BEGIN 
DECLARE @count int 
SELECT @count = COUNT (libcode) 
FROM library
 WHERE City = @common
 RETURN @count
 END

SELECT [dbo].[cities] ('homagama')
  
  CREATE FUNCTION [dbo].[finding_amount_of_public] 
(@common varchar (50))
RETURNS int
 AS 
BEGIN 
DECLARE @count int 
SELECT @count = COUNT (libcode) 
FROM library
 WHERE BranchType = @common
 RETURN @count
 END
 SELECT [dbo].[finding_amount_of_public] ('public')


 /**** Views ****/
CREATE VIEW 
lib_first3 
as 
SELECT libcode,BranchName, BranchType , LibraryType
FROM library
where libcode<=3
select * FROM lib_first3




CREATE view
 BranchAddress AS
SELECT City, LibNumber
FROM library
WHERE City = 'colombo';

select* from BranchAddress


/**** Procedure ****/
CREATE PROCEDURE 
FindingMain @LibType varchar(50)
AS
SELECT * FROM library WHERE LibraryType = @LibType
GO;

EXEC FindingMain  @LibType= 'Main';
end


CREATE PROCEDURE 
FindingSchool @BranchType varchar(50)
AS
SELECT * FROM library WHERE BranchType = @BranchType


EXEC FindingSchool @BranchType= 'school';



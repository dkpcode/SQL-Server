--How to Bulk insert to a table that has an auto commit primary key

--step1  create the table
--drop table dbo.SampleData;
CREATE TABLE dbo.SampleData(
id int identity(1,1) primary key not null,
company varchar(30) null,
address varchar(30) null,
city varchar(30) null,
state varchar(10) null,
zip varchar(10));

--STEP 2  create a view of the table exclusing the primarykey(id)
drop view dbo.vwInsertSampleData;
CREATE VIEW dbo.vwInsertSampleData as
select company, address, city, state, zip
from dbo.SampleData;

--STEP 3 BULK INSERT the company data from the .CSV file
BULK INSERT dbo.vwInsertSampleData
FROM 'C:\Users\Donnie Purvis\Documents\SQL Server Management Studio\Code Snippets\SQL\My Code Snippets\companies.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n',
    BATCHSIZE=250000,
    MAXERRORS=2);

--check inserted data
select * from dbo.SampleData;
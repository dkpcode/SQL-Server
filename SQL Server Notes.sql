--create table scratch
DROP TABLE DONNIE_TEST.DBO.NEWTABLE;
CREATE TABLE DONNIE_TEST.DBO.NEWTABLE
(BUS_ID INT IDENTITY(1,1) PRIMARY KEY,
BUSINESS_NAME VARCHAR(255) NOT NULL,
ADDRESS VARCHAR(255) NOT NULL,
CITY VARCHAR(50) NULL,
POSTALCODE VARCHAR(255) NULL);

INSERT INTO Donnie_Test.DBO.NEWTABLE
SELECT BUSINESS_NAME,ADDRESS, CITY, POSTALCODE 
FROM Donnie_Test.DBO.Business

SELECT * FROM DONNIE_TEST.DBO.NEWTABLE

--Altering a Table insert column, DROP PRIMARY KEY
ALTER TABLE employees
DROP CONSTRAINT employees_pk;

--set a foreign key in a table from a primary key
alter table table2 add column TagId int;

update table2 t2 join
       table1 t1
       on t2.TagName = t1.TagName
    set t2.TagId = t1.TagId;

alter table table2 add constraint fk_table2_tagid
    foreign key (TagId) references table1(TagId);

	select * from donnie_test.dbo.business

--lookup table difinition(i.e. table, columns, column type, size, etc)
sp_help 'Donnie_Test.dbo.Business2'

--select statements
SELECT * FROM Donnie_Test.dbo.Business2

--copy table
SELECT * 
INTO Donnie_Test.dbo.Business4
FROM Donnie_Test.dbo.Business2

--CREATE DROP/INDEX
CREATE INDEX ind_bus4 on Donnie_test.dbo.Business4(busid);
DROP INDEX ind_bus4 on Donnie_test.dbo.Business4;

--group by 
SELECT BUSINESS_NAME, ADDRESS, COUNT(*) rec_cnt
FROM Donnie_Test.dbo.Business4
GROUP BY Business_name,address
ORDER BY rec_cnt DESC

--create DEDUP master Table
SELECT distinct business_name,address
INTO DONNIE_TEST.DBO.Company_Master
from Donnie_Test.dbo.Business4

select * from Donnie_Test.dbo.Company_Master
order by 1, 2

SELECT business_name,address
INTO DONNIE_TEST.DBO.Company_Duplicates
from Donnie_Test.dbo.Business4

WITH CTE (Business_name,address, dupcnt)
AS
(
SELECT Business_name, address,
ROW_NUMBER() OVER (PARTITION BY business_name, address ORDER BY business_name) AS dupcnt
FROM Donnie_Test.dbo.Business4
)
DELETE
FROM CTE
WHERE dupcnt > 1
GO


--Recursive CTE  loops through second sql statement until condition met
WITH cte_numbers(n, weekday) 
AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n < 6
)
SELECT 
    *
FROM 
    cte_numbers;

	USE [Donnie_Test]




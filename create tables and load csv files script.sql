/*CREATES THE TABLE FOR DAILY ACTIVITY DATA*/
DROP TABLE data_daily_activity;
CREATE TABLE data_daily_activity(
id NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL,
dateActivity date NULL,
abTestGroup	varchar(20) NULL,
platform varchar(50) NULL,	
countryCode	char(50) NULL,
userId varchar(50) NULL,
UNIQUE(ID));

--IMPORT DATA VIA ORACLE FROM LOCATION OF .CSV FILE  C:/data_daily_activity.csv

--VERIFY DATA LOAD
SELECT * FROM DATA_DAILY_ACTIVITY;

--CREATE TABLE FOR IN APP PURCHASES DATA
drop TABLE data_in_app_purchases;
CREATE TABLE data_in_app_purchases(
id NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL,
dateActivity date NULL,
productId varchar(100) NULL,
cost varchar(50) NULL,
userId varchar(50) NULL,
UNIQUE (ID)
);

--IMPORT .CSV IN APP PURCHASES DATA C:/data_in_app_purchases.csv

--VERIFY DATA LOAD
SELECT * FROM data_in_app_purchases;

/*updated cost column setting NA value to nulls */
update data_in_app_purchases
set cost = null
where cost = 'NA';
commit;

/*create index on in_app_purchases userids*/
DROP INDEX USR;
create index usr on data_in_app_purchases(userid);

/*create index on daily activity userids*/
DROP INDEX USR1;
create index usr1 on data_daily_activity(userid);



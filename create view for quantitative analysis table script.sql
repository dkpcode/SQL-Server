/*creates view for analysis purposes*/
drop view vwquantitativeanalysis;
create view  vwQuantitativeAnalysis as
select  a.id,a.dateActivity as date_a, a.abTestGroup, a.platform,
a.countryCode, a.userId as user_a, b.userId as user_b, 
b.dateactivity as date_b, b.productId,   
cast(b.cost as decimal(10,3)) cost 
from  data_Daily_Activity a left outer join
data_In_App_Purchases b on a.userId=b.userId;

--check data
select * from vwquantitativeanalysis;
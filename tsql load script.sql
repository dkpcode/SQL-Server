---create index on in_app_purchases
  create index usr on dbo.In_App_Purchases(userid);
  
 GO

  ---create temp table with all records
  select try_convert(date,a.dateActivity) as date_a, a.abTestGroup, a.platform,
  a.countryCode, a.userId as user_a, b.userId as user_b, 
  try_convert(date,b.dateActivity) date_b, b.productId,   try_convert(float,b.cost) cost 
  into #master
  from  donnie_test.dbo.Daily_Activity a left outer join
  donnie_test.dbo.In_App_Purchases b on a.userId=b.userId
  
  go
  
  --sum of total spent by group
  select abtestgroup, sum(cost) total_spent  from #master
  group by abTestGroup;
  
GO

--when each country spent the most
select abTestGroup,date_b,sum(cost) t_spent_by_date 
from #master
where cost is not null
group by abTestGroup,date_b
order by 2 desc, 3 desc, 1 desc

GO 
  
--which country spent the most(sum by country code
  select  countrycode, sum(cost) total from #master
  group by countrycode
  order by 2 desc

GO

--country with most active users
select count(user_a) active_usr_cnt ,countrycode from #master where user_b is not null
group by countryCode
order by 1 desc
 
GO


 


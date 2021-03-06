--PARTITION QUERIES
SELECT ROW_NUMBER() OVER(PARTITION BY PRODUCTCATEGORYID ORDER BY SELLSTARTDATE) AS RNUM, PRODUCTCATEGORYID,SELLSTARTDATE 
FROM ADVENTUREWORKSLT2012.SALESLT.PRODUCT2
WHERE DATEPART(MONTH, SELLSTARTDATE) = 7
ORDER BY PRODUCTCATEGORYID


--COALESCE if value is missing use other value
select coalesce(size, color), * 
from ADVENTUREWORKSLT2012.SALESLT.PRODUCT
where coalesce(size, color) = 'Red';

--UNION (excludes duplicates)
Select top 10 * from adventureworkslt2012.saleslt.customer
union
Select top 10 * from adventureworkslt2012.saleslt.customer
order by 1

--UNION ALL (includes duplicates)
Select top 10 * from adventureworkslt2012.saleslt.customer
union all
Select top 10 * from adventureworkslt2012.saleslt.customer
order by 1

--INTERSECT  (matching rows/values)
Select top 25 a.CustomerID, a.FirstName, a.LastName from adventureworkslt2012.saleslt.customer a
intersect
Select top 10 b.CustomerID, b.FirstName, b.LastName from adventureworkslt2012.saleslt.customer b
order by 1

--EXCEPT (rows not matching)
Select TOP 25 a.CustomerID, a.FirstName, a.LastName FROM adventureworkslt2012.saleslt.customer a
except
Select TOP 10 b.CustomerID, b.FirstName, b.LastName FROM adventureworkslt2012.saleslt.customer b
order by 1

--PIVOT table summary counts
SELECT * FROM
(
SELECT c.ProductCategoryName, c.ProductID  
FROM DWAdventureWorksLT2012Lab01a.dbo.vETLDimProductsData c
) d  PIVOT ( COUNT(d.ProductID) for d.ProductCategoryName IN ([Mountain Bikes],[Road Bikes],[Touring Bikes],
                                                              [Handlebars],[Bottom Brackets],[Brakes],
															  [Chains],[Cranksets]
															  )) as product_counts


select stockcode, customer_id, invoicedate, quantity, sum(quantity) over(partition by stockcode order by invoicedate)  as total_quantity from tableretail order by stockcode,invoicedate; 

----------------------------------------------------------------------------------------------------------

with cte as (
select customer_id, sum(quantity*price) as sales from tableretail group by customer_id
)
select customer_id, sales, rank() over(order by sales desc) as "Rank" from cte;

----------------------------------------------------------------------------------------------------------

with cte as (
select stockcode,count(stockcode) as OrderCount from tableretail group by stockcode
)
select stockcode, OrderCount, dense_rank() over(order by OrderCount desc) as "Rank" from cte;  

----------------------------------------------------------------------------------------------------------

with cte as (
select stockcode,sum(quantity) as QuantitySold from tableretail group by stockcode
)
select stockcode, QuantitySold, dense_rank() over(order by QuantitySold desc) as "Rank" from cte;

-----------------------------------------------------------------------------------------------------------

with cte as (
select stockcode,sum(quantity*price) as TotalSales from tableretail group by stockcode
)
select stockcode, TotalSales, dense_rank() over(order by TotalSales desc) as "Rank" from cte;

-----------------------------------------------------------------------------------------------------------

select invoice,customer_id,invoicedate,extract(year from to_date(invoicedate, 'MM/DD/YYYY HH24:MI')) as Year,quantity,price,
    round(avg(quantity * price) over (partition by customer_id, extract(year from to_date(invoicedate, 'MM/DD/YYYY HH24:MI'))),2) as AvgSalesEachYear
from tableRetail;

-----------------------------------------------------------------------------------------------------------

select invoice,stockcode,invoicedate,extract(year from to_date(invoicedate, 'MM/DD/YYYY HH24:MI')) as Year,quantity,price,
    avg(quantity) over (partition by stockcode, extract(year from to_date(invoicedate, 'MM/DD/YYYY HH24:MI'))) as AvgQtyEachYear
from tableRetail;

-----------------------------------------------------------------------------------------------------------

select invoice,customer_id,invoicedate,extract(year from to_date(invoicedate,  'MM/DD/YYYY HH24:MI')) as Year,
    extract(month from to_date(invoicedate,  'MM/DD/YYYY HH24:MI')) as Month,quantity,price,
    sum(quantity * price) over (partition by customer_id, extract(year from to_date(invoicedate,  'MM/DD/YYYY HH24:MI')), extract (month from to_date(invoicedate,  'MM/DD/YYYY HH24:MI'))) as TotalSpentEachMonth
from tableRetail;

-----------------------------------------------------------------------------------------------------------

with cte as (
select customer_id, sum(quantity*price) as sales from tableretail group by customer_id
)
select customer_id, sales, round(cume_dist() over(order by sales desc),3) as "CumulativeRank" from cte;


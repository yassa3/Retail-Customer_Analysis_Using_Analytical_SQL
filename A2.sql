with 
dates_cte as (
select customer_id,count(distinct(invoice)) over(partition by customer_id) as frequency,
sum(quantity*price) over (partition by customer_id) as total_sales ,
first_value(to_date(invoicedate, 'MM/DD/YYYY HH24:MI')) over (order by to_date(invoicedate, 'MM/DD/YYYY HH24:MI') desc) as recent_date,
first_value(to_date(invoicedate, 'MM/DD/YYYY HH24:MI'))  over (partition by customer_id order by to_date(InvoiceDate, 'MM/DD/YYYY HH24:MI') desc) as last_date 
from tableretail),
r_cte as (
select customer_id, frequency, total_sales,
round(recent_date - last_date,0) as recency 
from dates_cte 
group by customer_id,frequency,total_sales,round(recent_date - last_date,0)),
fm_cte as (
select customer_id, recency, frequency,
round(percent_rank() over (order by total_sales),2) as monetary, (frequency+round(percent_rank() over (order by total_sales),2))/2 as avg_fm from r_cte),
rfm_scores_cte as (
select  customer_id, recency, frequency, monetary,
ntile(5) over(order by recency desc) as r_score, 
ntile(5) over(order by avg_fm) as fm_score 
from fm_cte)
select customer_id,recency,frequency,monetary,r_score,fm_score, 
    case
        when r_score = 5 and fm_score = 5 then ' Champions'  
        when r_score = 5 and fm_score = 4 then ' Champions'  
        when r_score = 4 and fm_score = 5 then ' Champions'  
        
        when r_score = 5 and fm_score = 2 then 'Potential Loyalists'  
        when r_score = 4 and fm_score = 2 then 'Potential Loyalists'  
        when r_score = 3 and fm_score = 3 then 'Potential Loyalists' 
        when r_score = 4 and fm_score = 3 then 'Potential Loyalists'  
        
        when r_score = 5 and fm_score = 3 then 'Loyal Customers'  
        when r_score = 4 and fm_score = 4 then 'Loyal Customers'  
        when r_score = 3 and fm_score = 5 then 'Loyal Customers'  
        when r_score = 3 and fm_score = 4 then 'Loyal Customers'  
        
        when r_score = 5 and fm_score = 1 then 'Recent Customers'  
        
        when r_score = 4 and fm_score = 1 then 'Promising'  
        when r_score = 3 and fm_score = 1 then 'Promising'  
        
        when r_score = 3 and fm_score = 2 then 'Customers Needing Attention'  
        when r_score = 2 and fm_score = 3 then 'Customers Needing Attention' 
        when r_score = 2 and fm_score = 2 then 'Customers Needing Attention'  
        
        when r_score = 2 and fm_score = 5 then 'At Rsik'  
        when r_score = 2 and fm_score = 4 then 'At Risk' 
        when r_score = 1 and fm_score = 3 then 'At Risk' 
        
        when r_score = 1 and fm_score = 5 then 'Can not Lose Them' 
        when r_score = 1 and fm_score = 4 then 'Can not Lose Them' 
        
        when r_score = 1 and fm_score = 2 then 'Hibernating' 
        
        when r_score = 1 and fm_score = 1 then 'Lost' 
        
        else 'UnCategorized'
    end as cust_segment   
from rfm_scores_cte order by customer_id;

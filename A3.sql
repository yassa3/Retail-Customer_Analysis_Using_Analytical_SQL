with group_cte as (
  select cust_id, calendar_dt, amt_le, row_number() over (partition by cust_id order by calendar_dt) as "Rank", calendar_dt - row_number() over  (partition by cust_id order by calendar_dt) as "Group"
  from daily_transactions
  where amt_le > 0
),
consecutive_cte as (
    select cust_id,"Group",count(*) as Consecutive_Days from group_cte group by cust_id,"Group"
)
select cust_id, max(Consecutive_Days) as Max_Consecutive_Days
from consecutive_cte
group by cust_id
order by cust_id;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

with cte as (
    select cust_id,calendar_dt, amt_le, sum(amt_le) over(partition by cust_id order by calendar_dt) as "SUM", row_number() over(partition by cust_id order by calendar_dt) as "Rank"
    , min(calendar_dt) over (partition by cust_id order by calendar_dt) as first_purchase
    from daily_transactions 
    order by cust_id
),
cte2 as (
    select cte.*, 
           case 
              WHEN "SUM" >= 250 THEN "Rank"
            end as transactions,
            case 
              WHEN "SUM" >= 250 THEN calendar_dt - first_purchase
            end as days 
     from cte
),
cte3 as (
select cust_id,min(transactions) as chosen_transaction , min(days) as chosen_day from cte2 group by cust_id 
)
select round(avg(chosen_transaction),0) as avg_transactions , round(avg(chosen_day),0) as avg_days from cte3;
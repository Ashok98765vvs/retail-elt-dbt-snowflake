-- mart_daily_revenue.sql: Daily revenue analytics mart
-- Aggregates order data into daily revenue metrics for BI reporting

{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }}
    where order_status != 'cancelled'
),

daily_metrics as (
    select
        order_date,
        count(distinct order_id)        as total_orders,
        count(distinct customer_id)     as unique_customers,
        sum(order_total)                as total_revenue,
        avg(order_total)                as avg_order_value,
        min(order_total)                as min_order_value,
        max(order_total)                as max_order_value
    from orders
    group by 1
),

final as (
    select
        order_date,
        total_orders,
        unique_customers,
        round(total_revenue, 2)         as total_revenue,
        round(avg_order_value, 2)       as avg_order_value,
        round(min_order_value, 2)       as min_order_value,
        round(max_order_value, 2)       as max_order_value,
        sum(total_revenue) over (
            order by order_date
            rows between unbounded preceding and current row
        )                               as cumulative_revenue
    from daily_metrics
)

select * from final
order by order_date desc

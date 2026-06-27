-- stg_orders.sql: Staging model for raw orders
-- Cleans and standardizes raw order data from source

with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        order_id::varchar          as order_id,
        customer_id::varchar       as customer_id,
        order_date::date           as order_date,
        status::varchar            as order_status,
        total_amount::numeric(10,2) as order_total,
        created_at::timestamp      as created_at
    from source
    where order_id is not null
)

select * from renamed

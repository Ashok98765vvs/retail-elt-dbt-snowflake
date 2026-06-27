-- stg_customers.sql: Staging model for raw customers

with source as (
    select * from {{ source('raw', 'customers') }}
),

renamed as (
    select
        customer_id::varchar    as customer_id,
        first_name::varchar     as first_name,
        last_name::varchar      as last_name,
        email::varchar          as email,
        city::varchar           as city,
        state::varchar          as state,
        created_at::timestamp   as created_at
    from source
    where customer_id is not null
)

select * from renamed

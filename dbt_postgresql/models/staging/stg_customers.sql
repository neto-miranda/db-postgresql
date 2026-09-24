with source as (

    select * from {{ source('public', 'customers') }}
),
renamed as (

    select
        customer_id as id_cliente,
        customer_unique_id as id_cliente_unico,
        customer_zip_code_prefix as cep,
        customer_city as cidade,
        customer_state as estado
    from source
)

select * from renamed
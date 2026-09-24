with source as (

    select * from {{ source('public', 'sellers') }}
),
renamed as (

    select
        seller_id as id_vendedor,
        seller_zip_code_prefix as cep_vendedor,
        seller_city as cidade_vendedor,
        seller_state as estado_vendedor
    from source
)

select * from renamed

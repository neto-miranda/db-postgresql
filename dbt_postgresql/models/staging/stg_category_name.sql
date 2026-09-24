with source as (

    select * from {{ source('public', 'product_category_name_translation') }}
),
renamed as (

    select
        product_category_name as nome_categoria,
        product_category_name_english as nome_categoria_ingles
    from source

) 
    select * from renamed

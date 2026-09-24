with source as (

    select * from {{ source('public', 'order_items') }}
),
renamed as (

    select
        order_id as id_pedido,
        order_item_id as id_item_pedido,        
        product_id as id_produto,
        seller_id as id_vendedor,
        shipping_limit_date::timestamp as prazo_entrega,
        price::numeric(15,2) as preco,
        freight_value::numeric(15,2) as valor_frete
    from source
)

select * from renamed
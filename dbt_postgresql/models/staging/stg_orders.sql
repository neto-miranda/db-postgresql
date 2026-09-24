with source as (
    select * from {{ source('public', 'orders') }}
), 
renamed as (

    select
        order_id as id_pedido,
        customer_id as id_cliente,
        order_status as status_pedido,
        order_purchase_timestamp::timestamp as data_compra,
        order_approved_at::timestamp as data_aprovacao,
        order_delivered_carrier_date::timestamp as data_entrega_carrier,
        order_delivered_customer_date::timestamp as data_entrega_cliente,
        order_estimated_delivery_date::timestamp as data_estimada_entrega
    from source
)

select * from renamed

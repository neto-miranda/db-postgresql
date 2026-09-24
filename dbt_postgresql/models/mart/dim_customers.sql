with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

order_payments as (
    select * from {{ ref('stg_order_payments') }}
),

customer_metrics as (
    select
        o.id_cliente,
        count(distinct o.id_pedido) as total_pedidos,
        min(o.data_compra) as data_primeira_compra,
        max(o.data_compra) as data_ultima_compra,
        sum(p.valor_pagamento) as total_gasto
    from orders o
    left join order_payments p on o.id_pedido = p.id_pedido
    group by 1
)

select
    c.id_cliente,
    c.id_cliente_unico,
    c.cidade,
    c.estado,
    c.cep,
    coalesce(m.total_pedidos, 0) as total_pedidos,
    m.data_primeira_compra,
    m.data_ultima_compra,
    coalesce(m.total_gasto, 0) as total_gasto
from customers c
left join customer_metrics m on c.id_cliente = m.id_cliente

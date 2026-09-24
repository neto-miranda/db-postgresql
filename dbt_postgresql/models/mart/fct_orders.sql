with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select
        id_pedido,
        sum(preco) as total_items_valor,
        sum(valor_frete) as total_frete,
        count(id_produto) as total_produtos
    from {{ ref('stg_order_items') }}
    group by 1
),

order_payments as (
    select
        id_pedido,
        sum(valor_pagamento) as total_pagamento,
        -- Agrupa os tipos de pagamento utilizados em uma string caso haja mais de um
        string_agg(distinct tipo_pagamento, ', ') as metodos_pagamento
    from {{ ref('stg_order_payments') }}
    group by 1
),

order_reviews as (
    select
        id_pedido,
        avg(nota_avaliacao) as media_avaliacao
    from {{ ref('stg_order_reviews') }}
    group by 1
)

select
    o.id_pedido,
    o.id_cliente,
    o.status_pedido,
    o.data_compra,
    o.data_aprovacao,
    o.data_entrega_cliente,
    o.data_estimada_entrega,
    
    -- Métricas financeiras e contagens
    coalesce(i.total_items_valor, 0) as total_items_valor,
    coalesce(i.total_frete, 0) as total_frete,
    coalesce(i.total_produtos, 0) as total_produtos,
    coalesce(p.total_pagamento, 0) as total_pagamento,
    p.metodos_pagamento,
    
    -- Avaliação do cliente
    r.media_avaliacao,
    
    -- Métrica calculada de tempo de entrega (em dias)
    extract(day from (o.data_entrega_cliente - o.data_compra)) as dias_entrega
from orders o
left join order_items i on o.id_pedido = i.id_pedido
left join order_payments p on o.id_pedido = p.id_pedido
left join order_reviews r on o.id_pedido = r.id_pedido

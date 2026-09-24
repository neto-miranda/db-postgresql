with source as (

    select * from {{ source('public', 'order_payments') }}
),
renamed as (

    select
        order_id as id_pedido,
        payment_sequential as sequencia_pagamento,
        payment_type as tipo_pagamento,
        payment_installments as parcelas_pagamento,
        payment_value::float as valor_pagamento
    from source
)

select * from renamed
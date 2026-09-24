with source as (

    select * from {{ source('public', 'order_reviews') }}
),
renamed as (

    select 
        order_id as id_pedido,
        review_id as id_avaliacao,
        review_score as nota_avaliacao,
        review_comment_title as titulo_avaliacao,
        review_comment_message::varchar as mensagem_avaliacao,
        review_creation_date::timestamp as data_criacao_avaliacao,
        review_answer_timestamp::timestamp as data_resposta_avaliacao
    from source
)

select * from renamed
with source as (

    select * from {{ source('public', 'products') }}
),
renamed as (
    
    select
        product_id as id_produto,
        product_category_name as id_categoria,
        product_name_lenght as tamanho_nome_produto,
        product_description_lenght as descricao_produto,
        product_photos_qty as quantidade_fotos_produto,
        product_weight_g as peso_produto,
        product_length_cm as comprimento_produto,
        product_height_cm as altura_produto,
        product_width_cm as largura_produto
    from source
)

select * from renamed
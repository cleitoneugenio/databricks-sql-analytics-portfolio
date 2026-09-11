# Dados

Este projeto utiliza o **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente no Kaggle.

Fonte: [Kaggle — Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). O recorte contém pedidos realizados entre 2016 e 2018.

## Escopo utilizado

As análises deste case usam principalmente os dados de pedidos, clientes e avaliações. No Databricks, esses dados foram organizados em tabelas e em uma view analítica que identifica pedidos entregues fora do prazo.

Por questões de tamanho e reprodutibilidade, os arquivos brutos não são versionados neste repositório. Faça o download a partir da fonte original e execute [`notebooks/00_ingestao_olist_delta.sql`](../notebooks/00_ingestao_olist_delta.sql) para criar as tabelas Delta no Databricks.

## Organização esperada

- `raw/`: arquivos originais obtidos no Kaggle;
- `processed/`: resultados agregados gerados pelas queries;
- `../notebooks/`: consultas reproduzíveis da análise;
- `../docs/dicionario-de-dados.md`: definição dos campos usados.

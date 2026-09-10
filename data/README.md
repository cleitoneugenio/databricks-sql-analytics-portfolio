# Dados

Este projeto utiliza o **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente no Kaggle.

Fonte: [Kaggle — Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Escopo utilizado

As análises deste case usam principalmente os dados de pedidos, clientes e avaliações. No Databricks, esses dados foram organizados em tabelas e em uma view analítica que identifica pedidos entregues fora do prazo.

Por questões de tamanho e reprodutibilidade, os arquivos brutos não são versionados neste repositório. Faça o download a partir da fonte original e carregue-os no ambiente Databricks de sua preferência.

## Organização esperada

- `raw/`: arquivos originais obtidos no Kaggle;
- `processed/`: dados tratados localmente, quando necessários;
- `../notebooks/`: consultas reproduzíveis da análise;
- `../docs/dicionario-de-dados.md`: definição dos campos usados.

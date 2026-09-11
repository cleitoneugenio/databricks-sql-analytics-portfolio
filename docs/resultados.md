# Resultados validados

Este é o ponto único de publicação dos resultados numéricos do case. README, página web e materiais de apresentação devem consumir os valores gerados a partir das queries do repositório, e não números digitados manualmente.

## Status atual

Pendente de execução após a unificação da regra de atraso por timestamp. Os números históricos presentes nos frames visuais devem ser tratados como referência de trabalho até que as consultas atualizadas sejam executadas no Databricks.

## Como gerar a versão publicável

1. Execute [`notebooks/00_ingestao_olist_delta.sql`](../notebooks/00_ingestao_olist_delta.sql), ajustando `olist.base_path`.
2. Execute [`notebooks/01_analise_olist.sql`](../notebooks/01_analise_olist.sql) para criar `vw_atraso_entrega`.
3. Execute as queries em `sql/01` a `sql/08`.
4. Exporte os resultados para `data/processed/kpis.json` e salve uma captura do dashboard em `assets/`.
5. Atualize este documento com data de execução, versão das queries e valores finais.

## Contrato para a página web

O arquivo `data/processed/kpis.json` deve ser gerado pelo processo acima. Não suba dados brutos; versionar apenas um resumo agregado, sem identificadores individuais.

Exemplo de estrutura:

~~~json
{
  "generated_at": "YYYY-MM-DD",
  "delay_definition": "order_delivered_customer_date > order_estimated_delivery_date",
  "metrics": {
    "pct_pedidos_atrasados": null,
    "atraso_medio_dias": null,
    "pct_recompra": null,
    "pct_frete_sobre_valor_total": null,
    "pct_valor_top_10pct_vendedores": null
  }
}
~~~

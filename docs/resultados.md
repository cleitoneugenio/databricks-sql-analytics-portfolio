# Resultados validados

Este é o ponto de referência dos resultados numéricos do case. README, página web e materiais de apresentação devem ser reconciliados com os valores gerados a partir das queries do repositório, e não com números digitados manualmente.

## Execução registrada

Execução em **10/09/2026**, no Databricks SQL Warehouse, sobre `workspace.default.orders`.

| Métrica | Valor |
| --- | ---: |
| Pedidos entregues analisados | 96.470 |
| Pedidos atrasados | 7.826 |
| Taxa de atraso | 8,11% |
| Atraso médio dos pedidos atrasados | 9,55 dias |

**Definição de atraso:** `order_delivered_customer_date > order_estimated_delivery_date`. A comparação usa data e hora completas. Os números históricos presentes nos frames são apenas referências visuais; os valores desta seção são a fonte publicada para esse recorte.

## Como gerar a versão publicável

1. Execute [`notebooks/00_ingestao_olist_delta.sql`](../notebooks/00_ingestao_olist_delta.sql), ajustando `olist.base_path`.
2. Execute [`notebooks/01_analise_olist.sql`](../notebooks/01_analise_olist.sql) para criar `vw_atraso_entrega`.
3. Execute as queries em `sql/01` a `sql/08`.
4. Atualize `data/processed/kpis.json` com os resultados agregados.
5. Atualize este documento e reconcilie a página pública com data de execução, versão das queries e valores finais.

## Contrato para a página web

O arquivo `data/processed/kpis.json` deve ser gerado pelo processo acima. Ele é o artefato agregado de referência para atualizar a página pública. Não suba dados brutos; versione apenas um resumo sem identificadores individuais.

Estrutura atual:

~~~json
{
  "generated_at": "2026-09-10",
  "delay_definition": "order_delivered_customer_date > order_estimated_delivery_date",
  "metrics": {
    "pedidos_entregues": 96470,
    "pedidos_atrasados": 7826,
    "pct_pedidos_atrasados": 8.11,
    "atraso_medio_dias": 9.55,
    "pct_recompra": null,
    "pct_frete_sobre_valor_total": null,
    "pct_valor_top_10pct_vendedores": null
  }
}
~~~

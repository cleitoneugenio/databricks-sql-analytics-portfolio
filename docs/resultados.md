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
| Clientes únicos analisados | 93.358 |
| Clientes que recompraram | 2.801 |
| Taxa de recompra | 3,00% |
| Nota média — entrega no prazo | 4,29 |
| Nota média — entrega atrasada | 2,57 |
| Diferença de nota — atrasada versus no prazo | -1,73 ponto |
| Frete sobre o valor total dos itens | 16,57% |
| Peso médio do frete por item | 32,09% |
| Itens com frete acima de 50% do preço | 16,81% |
| Itens com frete acima do preço | 3,66% |
| Vendedores analisados | 3.095 |
| Valor dos itens nos 10% maiores vendedores | 67,56% |
| Valor dos itens no 1% maior de vendedores | 26,07% |

**Definição de atraso:** `order_delivered_customer_date > order_estimated_delivery_date`. A comparação usa data e hora completas. Os números históricos presentes nos frames são apenas referências visuais; os valores desta seção são a fonte publicada para esse recorte.

## Evidência estatística e recorte estadual

A diferença de nota entre entregas atrasadas e no prazo tem **IC 95% de -1,77 a -1,69 ponto**, com erro-padrão de 0,0193. A comparação reúne 88.653 avaliações de pedidos no prazo e 7.700 de pedidos atrasados; trata-se de evidência observacional, não de causalidade isolada.

O ranking completo por UF, com mínimo de 100 pedidos, está em [`data/processed/atraso-por-estado.json`](../data/processed/atraso-por-estado.json). Os cinco maiores percentuais são AL (23,93%), MA (19,67%), PI (15,97%), CE (15,32%) e SE (15,22%). O RJ merece atenção pelo volume: 1.664 atrasos em 12.350 pedidos (13,47%).

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
    "pct_recompra": 3.00,
    "nota_media_no_prazo": 4.29,
    "nota_media_atrasado": 2.57,
    "pct_frete_sobre_valor_total": 16.57,
    "pct_frete_medio_por_item": 32.09,
    "pct_valor_top_10pct_vendedores": 67.56
  }
}
~~~

# Diagnóstico operacional — Case Olist

Este documento define a trilha analítica do diagnóstico. Ele não replica números manualmente: os valores publicados devem vir de [Resultados validados](resultados.md), após execução das queries atualizadas no Databricks.

## Regra única de atraso

Um pedido é classificado como atrasado quando `order_delivered_customer_date > order_estimated_delivery_date`. A comparação usa timestamps completos e alimenta a view `workspace.default.vw_atraso_entrega`.

`dias_atraso` é uma medida descritiva de calendário; ele não determina o indicador binário de atraso.

## Frentes analíticas e evidências

| Frente | Pergunta | Consulta reproduzível |
| --- | --- | --- |
| Entrega | Onde há atraso e qual é seu impacto nas avaliações? | [`sql/01`](../sql/01_atrasos_por_estado.sql), [`sql/02`](../sql/02_impacto_do_atraso_nas_avaliacoes.sql), [`sql/07`](../sql/07_resumo_atraso_entrega.sql), [`sql/08`](../sql/08_impacto_atraso_estatistica.sql) |
| Recompra | Qual parcela dos clientes únicos retorna e como a avaliação se relaciona a esse comportamento? | [`sql/03`](../sql/03_recompra_clientes.sql), [`sql/04`](../sql/04_recompra_por_avaliacao.sql) |
| Frete | Qual o peso do frete por item e sobre o valor total dos itens? | [`sql/05`](../sql/05_frete_vs_preco.sql) |
| Concentração | Quanto do valor vendido está concentrado nos maiores vendedores? | [`sql/06`](../sql/06_concentracao_vendedores.sql) |

## Interpretação responsável

- A comparação entre atraso e avaliação é observacional; o intervalo de confiança mostra precisão da diferença, não causalidade.
- `SUM(price)` é uma proxy de valor vendido, não receita contábil líquida.
- A métrica de frete por item e a razão entre somas respondem a perguntas diferentes; ambas são expostas com rótulos próprios.
- Rankings estaduais usam ao menos 100 pedidos, evitando conclusões baseadas em amostras pequenas.

## Publicação dos resultados

Depois de executar a carga e as queries, atualize [Resultados validados](resultados.md) e o agregado `data/processed/kpis.json`. Antes de atualizar a página pública, reconcilie seus números com esses dois artefatos para preservar uma fonte verificável para o case.

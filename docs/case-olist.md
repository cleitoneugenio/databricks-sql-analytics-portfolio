# Case Olist — entregas e satisfação do cliente

## Contexto

Este case usa o **Brazilian E-Commerce Public Dataset by Olist**, disponível publicamente no Kaggle, com pedidos realizados entre 2016 e 2018. O objetivo é investigar o desempenho de entrega e sua relação com a experiência do cliente.

## Perguntas de negócio

1. Quais estados apresentam maior taxa de atraso em uma base comparável?
2. Qual é a diferença na avaliação média entre pedidos no prazo e atrasados?
3. Qual o tamanho da amostra e a precisão estatística dessa diferença?

## Modelagem no Databricks

O notebook [`01_analise_olist.sql`](../notebooks/01_analise_olist.sql) cria `workspace.default.vw_atraso_entrega` a partir de `orders` e `customers`.

Um pedido é considerado atrasado apenas quando:

~~~sql
order_delivered_customer_date > order_estimated_delivery_date
~~~

Essa comparação usa timestamps completos. A medida `dias_atraso` é apenas descritiva e não define a classificação.

## Consultas reproduzíveis

- [`sql/01_atrasos_por_estado.sql`](../sql/01_atrasos_por_estado.sql)
- [`sql/02_impacto_do_atraso_nas_avaliacoes.sql`](../sql/02_impacto_do_atraso_nas_avaliacoes.sql)
- [`sql/07_resumo_atraso_entrega.sql`](../sql/07_resumo_atraso_entrega.sql)
- [`sql/08_impacto_atraso_estatistica.sql`](../sql/08_impacto_atraso_estatistica.sql)

## Resultados

Os resultados numéricos e a imagem do dashboard serão publicados em [Resultados validados](resultados.md) depois da execução das consultas atualizadas. Isso evita divergência entre o case, o README e a página web.

## Recomendação operacional

Após a execução, priorize estados com taxa de atraso elevada e amostra suficiente; investigue rota, transportadora e prazo prometido. A comparação com avaliações deve ser usada como evidência de experiência do cliente, sem inferir causalidade isoladamente.

---

**Tecnologias:** Databricks, SQL, Delta Lake e análise de KPIs operacionais.

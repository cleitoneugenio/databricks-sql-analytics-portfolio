# Diagnóstico operacional — Case Olist

Este documento conecta os achados do diagnóstico à consulta SQL que os reproduz. Todas as análises usam o dataset público da Olist e devem ser interpretadas como evidências de priorização, não como prova de causalidade.

## 1. Recompra é baixa

O diagnóstico identificou **96.096 clientes únicos**, dos quais **3,12% recompraram**. A consulta agrupa os pedidos entregues pelo identificador persistente `customer_unique_id`, evitando tratar o mesmo cliente como pessoas diferentes em pedidos distintos.

Consulta: [`sql/03_recompra_clientes.sql`](../sql/03_recompra_clientes.sql).

## 2. Atraso compromete a experiência, mas não explica sozinho a recompra

Pedidos no prazo tiveram nota média de **4,29**; pedidos atrasados, **2,57**. A taxa global de atraso observada foi **6,8%**, com atraso médio de **10,6 dias** nos pedidos atrasados.

Na comparação por recompra, as notas médias foram próximas: **4,08** para quem não recomprou e **4,11** para quem recomprou. Isso indica que a satisfação é relevante, mas não basta para explicar o retorno do cliente.

Consultas: [`sql/07_resumo_atraso_entrega.sql`](../sql/07_resumo_atraso_entrega.sql), [`sql/02_impacto_do_atraso_nas_avaliacoes.sql`](../sql/02_impacto_do_atraso_nas_avaliacoes.sql) e [`sql/04_recompra_por_avaliacao.sql`](../sql/04_recompra_por_avaliacao.sql).

## 3. O atraso é regional

Alagoas (23,9%), Maranhão (19,7%) e Rio de Janeiro (13,5%) merecem atenção. A análise estadual usa uma amostra mínima de 100 pedidos para reduzir ruído de estados pouco representativos.

Consulta: [`sql/01_atrasos_por_estado.sql`](../sql/01_atrasos_por_estado.sql).

## 4. Frete é uma fricção comercial

O frete médio correspondeu a **16,6%** do preço do produto. Em **16,8%** dos itens, o frete superou metade do preço; em **3,7%**, superou o próprio preço do item.

Consulta: [`sql/05_frete_vs_preco.sql`](../sql/05_frete_vs_preco.sql).

## 5. Há risco de concentração de vendedores

Dos **3.095 vendedores**, os 10% com maior valor vendido concentraram **67,5%** da proxy de receita, e o 1% superior concentrou **25,7%**. A métrica usa `SUM(price)` como proxy de valor vendido; ela não equivale a receita contábil líquida.

Consulta: [`sql/06_concentracao_vendedores.sql`](../sql/06_concentracao_vendedores.sql).

## Prioridades recomendadas

1. Reduzir atraso em estados críticos por meio de investigação de rota, transportadora e prazo prometido.
2. Revisar frete para itens de menor preço, onde o peso relativo é maior.
3. Investigar os determinantes reais da recompra além da nota de avaliação.
4. Mitigar dependência comercial dos vendedores mais relevantes.

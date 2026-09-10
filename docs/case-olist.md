# Case Olist — atrasos de entrega e satisfação do cliente

## Contexto

Este case utiliza o **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente no Kaggle. O objetivo é investigar como atrasos de entrega afetam a experiência do cliente e identificar estados que merecem atenção operacional.

## Perguntas de negócio

1. Quais estados apresentam as maiores taxas de atraso, considerando uma base mínima de pedidos?
2. Qual é a diferença na avaliação média entre pedidos entregues no prazo e pedidos atrasados?
3. Onde a operação deve priorizar investigação e melhoria?

## Modelagem no Databricks

As análises usam a view `workspace.default.vw_atraso_entrega`, que consolida o status de atraso por pedido, e a tabela `workspace.default.order_reviews`, com as avaliações dos clientes.

As queries reproduzíveis estão em:

- `sql/01_atrasos_por_estado.sql`
- `sql/02_impacto_do_atraso_nas_avaliacoes.sql`

## Principais resultados

### Atraso por estado

Aplicando o critério de pelo menos 100 pedidos por estado, os maiores percentuais observados foram:

| Estado | Pedidos | Pedidos atrasados | Taxa de atraso |
| --- | ---: | ---: | ---: |
| AL | 397 | 95 | 23,9% |
| MA | 717 | 141 | 19,7% |
| PI | 476 | 76 | 16,0% |
| CE | 1.279 | 196 | 15,3% |
| BA | 3.256 | 457 | 14,0% |

Embora São Paulo concentre o maior volume absoluto da amostra (40.494 pedidos), sua taxa de atraso é 5,9%. Alto volume não significa, automaticamente, pior desempenho relativo.

### Impacto na satisfação

| Status de entrega | Nota média |
| --- | ---: |
| No prazo | 4,29 |
| Atrasado | 2,57 |

Pedidos atrasados têm uma avaliação média **1,72 ponto menor**. O atraso, portanto, não é apenas um indicador logístico: ele tem relação direta com a percepção de qualidade do cliente.

## Recomendação operacional

1. Investigar rotas, transportadoras e prazos prometidos em AL, MA, PI e CE.
2. Acompanhar separadamente volume de pedidos atrasados e taxa de atraso.
3. Monitorar semanalmente a nota média por status de entrega.

## Dashboard

O dashboard foi criado no Databricks com duas visualizações:

- taxa de atraso por estado;
- comparação entre atraso e nota média de avaliação.

> O dashboard permanece privado no workspace Databricks. Para fins de portfólio, a imagem deve ser adicionada em `assets/dashboard-olist.png`.

---

**Tecnologias:** Databricks, SQL, Delta Lake e análise de KPIs operacionais.

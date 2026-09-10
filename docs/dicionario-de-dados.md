# Dicionário de dados — Case Olist

Este dicionário cobre os campos empregados nas consultas do projeto. Os nomes seguem a organização utilizada no workspace Databricks.

## `workspace.default.orders`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `order_id` | texto | Identificador único do pedido. |
| `customer_id` | texto | Chave de relacionamento com a tabela de clientes. |
| `order_status` | texto | Situação do pedido; o case considera apenas `delivered`. |
| `order_delivered_customer_date` | data/hora | Data efetiva de entrega ao cliente. |
| `order_estimated_delivery_date` | data/hora | Data prometida para a entrega. |

## `workspace.default.customers`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `customer_id` | texto | Chave de relacionamento com a tabela de pedidos. |
| `customer_unique_id` | texto | Identificador persistente do cliente, usado para medir recompra entre pedidos. |
| `customer_state` | texto | UF do cliente. |

## `workspace.default.order_items`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `order_id` | texto | Identificador do pedido ao qual o item pertence. |
| `seller_id` | texto | Identificador do vendedor responsável pelo item. |
| `price` | decimal | Preço do item; usado como proxy de valor vendido. |
| `freight_value` | decimal | Valor do frete associado ao item. |

## `workspace.default.vw_atraso_entrega`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `order_id` | texto | Identificador único do pedido. |
| `customer_state` | texto | UF do cliente associada ao pedido. |
| `atrasado` | inteiro/booleano | Indicador de atraso: `0` para entrega no prazo e `1` para entrega atrasada. |

## Campos derivados durante a análise

| Campo | Regra | Descrição |
| --- | --- | --- |
| `dias_atraso` | `DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date)` | Diferença, em dias, entre a entrega efetiva e a data prometida. |
| `status_entrega` | `CASE WHEN dias_atraso > 0 THEN 'Atrasado' ELSE 'No prazo' END` | Rótulo legível para o resultado do cálculo de atraso. |

## `workspace.default.order_reviews`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `order_id` | texto | Identificador do pedido, usado para relacionar a avaliação à entrega. |
| `review_score` | inteiro | Nota atribuída pelo cliente, na escala de 1 a 5. |

## Métricas derivadas

| Métrica | Fórmula | Uso no case |
| --- | --- | --- |
| `total_pedidos` | `COUNT(*)` | Dimensiona o volume por estado. |
| `pedidos_atrasados` | `SUM(atrasado)` | Quantifica ocorrências de atraso. |
| `pct_atraso` | `AVG(atrasado) * 100` | Compara o desempenho relativo entre estados. |
| `nota_media` | `AVG(review_score)` | Mede a satisfação média por status de entrega. |
| `pct_recompra` | `AVG(total_pedidos > 1) * 100` | Percentual de clientes únicos com mais de um pedido entregue. |
| `pct_frete_medio_sobre_preco` | `AVG(freight_value / price) * 100` | Peso médio do frete em relação ao preço do item. |
| `pct_valor_top_10pct_vendedores` | `SUM(valor_top_10pct) / SUM(valor_total) * 100` | Concentração do valor vendido nos 10% maiores vendedores. |

> Para a análise estadual, são considerados somente estados com pelo menos 100 pedidos, reduzindo distorções de amostras pequenas.

# Dicionário de dados — Case Olist

Este dicionário cobre os campos empregados nas consultas do projeto. Os nomes seguem a organização utilizada no workspace Databricks.

## `workspace.default.vw_atraso_entrega`

| Campo | Tipo esperado | Descrição |
| --- | --- | --- |
| `order_id` | texto | Identificador único do pedido. |
| `customer_state` | texto | UF do cliente associada ao pedido. |
| `atrasado` | inteiro/booleano | Indicador de atraso: `0` para entrega no prazo e `1` para entrega atrasada. |

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

> Para a análise estadual, são considerados somente estados com pelo menos 100 pedidos, reduzindo distorções de amostras pequenas.

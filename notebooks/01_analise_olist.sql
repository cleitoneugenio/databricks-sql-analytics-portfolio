-- Databricks notebook source
-- Live Case Olist | Atraso de entrega, estado do cliente e nota de avaliação
-- Dataset público Olist, carregado no workspace.default.
-- Os sete passos abaixo devem ser executados em ordem.

-- COMMAND ----------

-- PASSO 1 | Inspecionar a tabela bruta de pedidos
-- Exibe uma amostra sem filtros para conhecer a estrutura de origem.
SELECT *
FROM workspace.default.orders
LIMIT 20;

-- COMMAND ----------

-- PASSO 2 | Calcular a diferença de calendário em dias
-- dias_atraso é descritivo. A classificação oficial de atraso será feita por timestamp no passo 3.
SELECT
  order_id,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  DATEDIFF(
    order_delivered_customer_date,
    order_estimated_delivery_date
  ) AS dias_atraso
FROM workspace.default.orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
LIMIT 20;

-- COMMAND ----------

-- PASSO 3 | Traduzir a entrega para uma categoria de negócio
-- O critério oficial compara timestamps completos: entrega após o prazo prometido é atraso.
SELECT
  order_id,
  dias_atraso,
  CASE
    WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 'Atrasado'
    ELSE 'No prazo'
  END AS status_entrega
FROM (
  SELECT
    order_id,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    DATEDIFF(
      order_delivered_customer_date,
      order_estimated_delivery_date
    ) AS dias_atraso
  FROM workspace.default.orders
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
LIMIT 20;

-- COMMAND ----------

-- PASSO 4 | Criar a base analítica de atraso e validar o volume por estado
-- A view é a fonte oficial do indicador atrasado e usa a mesma comparação de timestamps do passo 3.
CREATE OR REPLACE VIEW workspace.default.vw_atraso_entrega AS
SELECT
  o.order_id,
  c.customer_state,
  CASE
    WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
    ELSE 0
  END AS atrasado
FROM workspace.default.orders o
JOIN workspace.default.customers c
  ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;

SELECT
  customer_state,
  COUNT(*) AS total_pedidos
FROM workspace.default.vw_atraso_entrega
GROUP BY customer_state
ORDER BY total_pedidos DESC;

-- COMMAND ----------

-- PASSO 5 | Contar pedidos atrasados por estado
-- Como atrasado vale 1 ou 0, SUM(atrasado) equivale à quantidade de pedidos atrasados.
SELECT
  customer_state,
  COUNT(*) AS total_pedidos,
  SUM(atrasado) AS pedidos_atrasados
FROM workspace.default.vw_atraso_entrega
GROUP BY customer_state
ORDER BY total_pedidos DESC;

-- COMMAND ----------

-- PASSO 6 | Calcular a taxa de atraso e priorizar estados com amostra suficiente
-- A média de uma coluna binária é a proporção de valores iguais a 1.
SELECT
  customer_state,
  COUNT(*) AS total_pedidos,
  SUM(atrasado) AS pedidos_atrasados,
  ROUND(AVG(atrasado) * 100, 1) AS pct_atraso
FROM workspace.default.vw_atraso_entrega
GROUP BY customer_state
HAVING COUNT(*) >= 100
ORDER BY pct_atraso DESC;

-- COMMAND ----------

-- PASSO 7 | Relacionar atraso e satisfação do cliente
SELECT
  v.atrasado,
  ROUND(AVG(r.review_score), 2) AS nota_media
FROM workspace.default.vw_atraso_entrega v
JOIN workspace.default.order_reviews r
  ON v.order_id = r.order_id
GROUP BY v.atrasado;

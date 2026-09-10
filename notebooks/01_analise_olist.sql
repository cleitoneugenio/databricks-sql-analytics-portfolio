-- Databricks notebook source
-- Case Olist: atrasos de entrega e satisfação do cliente
-- Pré-requisitos: workspace.default.vw_atraso_entrega e
-- workspace.default.order_reviews disponíveis no ambiente.

-- COMMAND ----------

-- Taxa de atraso por estado do cliente.
-- Mantém apenas estados com pelo menos 100 pedidos para reduzir distorções de amostra.
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

-- Relação entre atraso na entrega e satisfação do cliente.
-- 0 = pedido entregue no prazo | 1 = pedido entregue com atraso.
SELECT
  v.atrasado,
  ROUND(AVG(r.review_score), 2) AS nota_media
FROM workspace.default.vw_atraso_entrega v
JOIN workspace.default.order_reviews r
  ON v.order_id = r.order_id
GROUP BY v.atrasado;

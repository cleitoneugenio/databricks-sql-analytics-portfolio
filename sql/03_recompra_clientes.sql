-- Frequência de recompra entre clientes únicos
-- Considera apenas pedidos efetivamente entregues.

WITH compras_por_cliente AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_pedidos
  FROM workspace.default.orders o
  JOIN workspace.default.customers c
    ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  COUNT(*) AS clientes_unicos,
  SUM(CASE WHEN total_pedidos = 1 THEN 1 ELSE 0 END) AS compraram_uma_vez,
  SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) AS recompraram,
  ROUND(AVG(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) * 100, 2) AS pct_recompra
FROM compras_por_cliente;

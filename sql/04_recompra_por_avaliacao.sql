-- Avaliação média conforme ocorrência de recompra
-- O agrupamento é feito pelo cliente único, não pelo customer_id do pedido.

WITH compras_por_cliente AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_pedidos
  FROM workspace.default.orders o
  JOIN workspace.default.customers c
    ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
),
avaliacoes_por_cliente AS (
  SELECT
    c.customer_unique_id,
    AVG(r.review_score) AS nota_media_cliente
  FROM workspace.default.orders o
  JOIN workspace.default.customers c
    ON o.customer_id = c.customer_id
  JOIN workspace.default.order_reviews r
    ON o.order_id = r.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  CASE
    WHEN cp.total_pedidos > 1 THEN 'Recomprou'
    ELSE 'Não recomprou'
  END AS status_recompra,
  ROUND(AVG(apc.nota_media_cliente), 2) AS nota_media
FROM compras_por_cliente cp
JOIN avaliacoes_por_cliente apc
  ON cp.customer_unique_id = apc.customer_unique_id
GROUP BY status_recompra
ORDER BY status_recompra;

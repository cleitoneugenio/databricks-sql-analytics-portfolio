-- Databricks notebook source
-- Diagnóstico operacional Olist | Recompra, frete e concentração de vendedores
-- Execute após a carga de orders, customers, order_reviews e order_items.

-- COMMAND ----------

-- 1. Recompra: clientes que fizeram mais de um pedido entregue.
WITH compras_por_cliente AS (
  SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS total_pedidos
  FROM workspace.default.orders o
  JOIN workspace.default.customers c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  COUNT(*) AS clientes_unicos,
  SUM(CASE WHEN total_pedidos = 1 THEN 1 ELSE 0 END) AS compraram_uma_vez,
  SUM(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) AS recompraram,
  ROUND(AVG(CASE WHEN total_pedidos > 1 THEN 1 ELSE 0 END) * 100, 2) AS pct_recompra
FROM compras_por_cliente;

-- COMMAND ----------

-- 2. Avaliação média por grupo de recompra.
WITH compras_por_cliente AS (
  SELECT c.customer_unique_id, COUNT(DISTINCT o.order_id) AS total_pedidos
  FROM workspace.default.orders o
  JOIN workspace.default.customers c ON o.customer_id = c.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
),
avaliacoes_por_cliente AS (
  SELECT c.customer_unique_id, AVG(r.review_score) AS nota_media_cliente
  FROM workspace.default.orders o
  JOIN workspace.default.customers c ON o.customer_id = c.customer_id
  JOIN workspace.default.order_reviews r ON o.order_id = r.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  CASE WHEN cp.total_pedidos > 1 THEN 'Recomprou' ELSE 'Não recomprou' END AS status_recompra,
  ROUND(AVG(apc.nota_media_cliente), 2) AS nota_media
FROM compras_por_cliente cp
JOIN avaliacoes_por_cliente apc ON cp.customer_unique_id = apc.customer_unique_id
GROUP BY status_recompra;

-- COMMAND ----------

-- 3. Peso do frete sobre o preço do produto.
SELECT
  ROUND(AVG(freight_value / NULLIF(price, 0)) * 100, 1) AS pct_frete_medio_sobre_preco,
  ROUND(AVG(CASE WHEN freight_value > price * 0.5 THEN 1 ELSE 0 END) * 100, 1)
    AS pct_itens_frete_acima_de_50pct,
  ROUND(AVG(CASE WHEN freight_value > price THEN 1 ELSE 0 END) * 100, 1)
    AS pct_itens_frete_acima_do_preco
FROM workspace.default.order_items;

-- COMMAND ----------

-- 4. Concentração do valor vendido por vendedor.
WITH valor_por_vendedor AS (
  SELECT seller_id, SUM(price) AS valor_vendido
  FROM workspace.default.order_items
  GROUP BY seller_id
),
vendedores_ordenados AS (
  SELECT
    seller_id,
    valor_vendido,
    NTILE(100) OVER (ORDER BY valor_vendido DESC) AS percentil_vendedor
  FROM valor_por_vendedor
)
SELECT
  COUNT(*) AS total_vendedores,
  ROUND(SUM(CASE WHEN percentil_vendedor <= 10 THEN valor_vendido ELSE 0 END)
    / SUM(valor_vendido) * 100, 1) AS pct_valor_top_10pct_vendedores,
  ROUND(SUM(CASE WHEN percentil_vendedor = 1 THEN valor_vendido ELSE 0 END)
    / SUM(valor_vendido) * 100, 1) AS pct_valor_top_1pct_vendedores
FROM vendedores_ordenados;

-- Concentração do valor dos itens vendidos entre vendedores
-- SUM(price) é uma proxy de valor vendido; não representa receita contábil líquida.

WITH valor_por_vendedor AS (
  SELECT
    seller_id,
    SUM(price) AS valor_vendido
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
  ROUND(
    SUM(CASE WHEN percentil_vendedor <= 10 THEN valor_vendido ELSE 0 END)
      / SUM(valor_vendido) * 100,
    1
  ) AS pct_valor_top_10pct_vendedores,
  ROUND(
    SUM(CASE WHEN percentil_vendedor = 1 THEN valor_vendido ELSE 0 END)
      / SUM(valor_vendido) * 100,
    1
  ) AS pct_valor_top_1pct_vendedores
FROM vendedores_ordenados;

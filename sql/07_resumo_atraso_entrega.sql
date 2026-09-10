-- Resumo geral de atraso de entrega
-- Sustenta a taxa global de atraso e o atraso médio dos pedidos que chegaram após o prazo.

WITH entregas AS (
  SELECT
    DATEDIFF(
      order_delivered_customer_date,
      order_estimated_delivery_date
    ) AS dias_atraso
  FROM workspace.default.orders
  WHERE order_status = 'delivered'
    AND order_delivered_customer_date IS NOT NULL
)
SELECT
  ROUND(AVG(CASE WHEN dias_atraso > 0 THEN 1 ELSE 0 END) * 100, 1) AS pct_pedidos_atrasados,
  ROUND(AVG(CASE WHEN dias_atraso > 0 THEN dias_atraso END), 1) AS atraso_medio_dias
FROM entregas;

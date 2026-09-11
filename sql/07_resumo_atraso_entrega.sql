-- Resumo geral de atraso de entrega
-- Sustenta a taxa global de atraso e o atraso médio dos pedidos que chegaram após o prazo.

WITH entregas AS (
  SELECT
    v.atrasado,
    CASE
      WHEN v.atrasado = 1 THEN
        (UNIX_TIMESTAMP(o.order_delivered_customer_date)
          - UNIX_TIMESTAMP(o.order_estimated_delivery_date)) / 86400.0
    END AS atraso_em_dias
  FROM workspace.default.vw_atraso_entrega v
  JOIN workspace.default.orders o
    ON v.order_id = o.order_id
)
SELECT
  ROUND(AVG(atrasado) * 100, 1) AS pct_pedidos_atrasados,
  ROUND(AVG(atraso_em_dias), 1) AS atraso_medio_dias
FROM entregas;

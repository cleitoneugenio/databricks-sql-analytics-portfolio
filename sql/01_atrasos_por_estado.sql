-- Taxa de atraso por estado do cliente
-- Mantém apenas estados com ao menos 100 pedidos para reduzir distorções de amostra.

SELECT
  customer_state,
  COUNT(*) AS total_pedidos,
  SUM(atrasado) AS pedidos_atrasados,
  ROUND(AVG(atrasado) * 100, 1) AS pct_atraso
FROM workspace.default.vw_atraso_entrega
GROUP BY customer_state
HAVING COUNT(*) >= 100
ORDER BY pct_atraso DESC;

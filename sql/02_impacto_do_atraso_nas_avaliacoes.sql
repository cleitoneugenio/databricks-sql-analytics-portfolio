-- Relação entre atraso na entrega e satisfação do cliente
-- 0 = pedido entregue no prazo | 1 = pedido entregue com atraso

SELECT
  v.atrasado,
  ROUND(AVG(r.review_score), 2) AS nota_media
FROM workspace.default.vw_atraso_entrega v
JOIN workspace.default.order_reviews r
  ON v.order_id = r.order_id
GROUP BY v.atrasado;

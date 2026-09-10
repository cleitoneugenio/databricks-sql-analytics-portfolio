-- Peso do frete sobre o preço dos itens vendidos
-- NULLIF evita divisão por zero em itens sem preço válido.

SELECT
  ROUND(AVG(freight_value / NULLIF(price, 0)) * 100, 1) AS pct_frete_medio_sobre_preco,
  ROUND(
    AVG(CASE WHEN freight_value > price * 0.5 THEN 1 ELSE 0 END) * 100,
    1
  ) AS pct_itens_frete_acima_de_50pct,
  ROUND(
    AVG(CASE WHEN freight_value > price THEN 1 ELSE 0 END) * 100,
    1
  ) AS pct_itens_frete_acima_do_preco
FROM workspace.default.order_items;

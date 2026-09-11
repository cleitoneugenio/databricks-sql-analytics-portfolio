-- Evidência estatística da diferença de avaliação entre pedidos no prazo e atrasados.
-- Reporta tamanho de amostra, média, desvio-padrão, diferença e IC 95% aproximado (normal).

WITH grupos AS (
  SELECT
    v.atrasado,
    COUNT(r.review_score) AS n,
    AVG(r.review_score) AS media,
    STDDEV_SAMP(r.review_score) AS desvio_padrao
  FROM workspace.default.vw_atraso_entrega v
  JOIN workspace.default.order_reviews r
    ON v.order_id = r.order_id
  GROUP BY v.atrasado
),
comparacao AS (
  SELECT
    MAX(CASE WHEN atrasado = 0 THEN n END) AS n_no_prazo,
    MAX(CASE WHEN atrasado = 1 THEN n END) AS n_atrasado,
    MAX(CASE WHEN atrasado = 0 THEN media END) AS media_no_prazo,
    MAX(CASE WHEN atrasado = 1 THEN media END) AS media_atrasado,
    MAX(CASE WHEN atrasado = 0 THEN desvio_padrao END) AS dp_no_prazo,
    MAX(CASE WHEN atrasado = 1 THEN desvio_padrao END) AS dp_atrasado
  FROM grupos
)
SELECT
  n_no_prazo,
  n_atrasado,
  ROUND(media_no_prazo, 2) AS media_no_prazo,
  ROUND(media_atrasado, 2) AS media_atrasado,
  ROUND(media_atrasado - media_no_prazo, 2) AS diferenca_media,
  ROUND(SQRT(POWER(dp_no_prazo, 2) / n_no_prazo + POWER(dp_atrasado, 2) / n_atrasado), 4)
    AS erro_padrao,
  ROUND(
    (media_atrasado - media_no_prazo)
      - 1.96 * SQRT(POWER(dp_no_prazo, 2) / n_no_prazo + POWER(dp_atrasado, 2) / n_atrasado),
    2
  ) AS ic95_inferior,
  ROUND(
    (media_atrasado - media_no_prazo)
      + 1.96 * SQRT(POWER(dp_no_prazo, 2) / n_no_prazo + POWER(dp_atrasado, 2) / n_atrasado),
    2
  ) AS ic95_superior
FROM comparacao;

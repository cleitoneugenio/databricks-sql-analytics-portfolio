# Notebooks Databricks

O arquivo [`01_analise_olist.sql`](01_analise_olist.sql) é um notebook SQL exportável para o Databricks. Ele reproduz a jornada completa do case, desde a inspeção da tabela bruta até o cruzamento entre atraso e avaliação.

## Sequência de execução

1. Inspeção da tabela `orders`;
2. cálculo de `dias_atraso` com `DATEDIFF`;
3. categorização do resultado com subquery e `CASE`;
4. criação da view `vw_atraso_entrega` com `JOIN` entre pedidos e clientes;
5. contagem de pedidos atrasados com `SUM`;
6. cálculo da taxa de atraso com `AVG`, `ROUND` e filtro `HAVING`;
7. cruzamento com `order_reviews` para calcular a nota média por status de entrega.

Antes da execução, carregue no `workspace.default` as tabelas `orders`, `customers` e `order_reviews`. Consulte o [dicionário de dados](../docs/dicionario-de-dados.md) para os campos requeridos.

O notebook [`02_diagnostico_operacional_olist.sql`](02_diagnostico_operacional_olist.sql) amplia o case com consultas sobre recompra, frete e concentração de vendedores. Para executá-lo, a tabela `order_items` também deve estar disponível.

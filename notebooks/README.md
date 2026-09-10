# Notebooks Databricks

O arquivo `01_analise_olist.sql` é um notebook SQL exportável para o Databricks e reúne as duas análises que sustentam o case:

1. taxa de atraso por estado;
2. impacto do atraso na avaliação média do cliente.

Antes da execução, o ambiente deve disponibilizar a view `workspace.default.vw_atraso_entrega` e a tabela `workspace.default.order_reviews`. Consulte o [dicionário de dados](../docs/dicionario-de-dados.md) para entender os campos requeridos.

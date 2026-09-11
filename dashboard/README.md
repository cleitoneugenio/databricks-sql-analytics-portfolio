# Visualização do case

A experiência pública do projeto está em [Diagnóstico Operacional Olist](https://cleiton-dados.vercel.app/diagnostico-olist). Ela é a camada principal para recrutadores e pessoas que desejam compreender rapidamente o contexto, os indicadores e as recomendações do case.

## Papel de cada camada

- **Página pública:** narrativa executiva, visualização dos indicadores e recomendações.
- **Repositório:** queries, notebooks, documentação metodológica e resultados agregados para rastreabilidade.
- **Databricks:** carga dos dados, criação das tabelas Delta e execução/validação das consultas.

## Dashboard no Databricks

O dashboard foi construído e utilizado durante a análise no Databricks. Não há uma exportação dele versionada neste repositório; por isso, não há captura ou arquivo de dashboard a ser aberto aqui. A ausência desse artefato não substitui a trilha técnica: os notebooks e as queries reproduzem os indicadores, e os resultados executados estão em [Resultados validados](../docs/resultados.md).

Para o portfólio, a página pública é a apresentação oficial do case. O dashboard do Databricks continua sendo evidência do processo técnico de construção e validação.

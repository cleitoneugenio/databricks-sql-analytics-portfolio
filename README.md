# Olist | Diagnóstico Operacional de E-commerce

> Case de análise de dados operacionais com Databricks e SQL sobre recompra, atrasos logísticos, frete e concentração de vendedores.

**Quer explorar a análise primeiro?** Acesse o [Diagnóstico Operacional Olist](https://cleiton-dados.vercel.app/diagnostico-olist), a versão pública e executiva deste case.

## Visão do case

Este projeto analisa dados públicos do e-commerce brasileiro da Olist para responder a uma pergunta relevante para operações: **quais fricções reduzem a experiência do cliente e onde a operação deve priorizar melhorias?**

O foco não é apenas descrever números. É transformar dados de pedidos e avaliações em sinais claros para priorização operacional.

## Fonte dos dados

Os dados utilizados são públicos: [Brazilian E-Commerce Public Dataset by Olist, no Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

O recorte temporal do dataset compreende pedidos realizados entre **2016 e 2018**. Os arquivos brutos não são versionados aqui para manter o repositório leve. A [documentação dos dados](data/README.md) explica a origem, o escopo e como reproduzir a carga no Databricks.

## Perguntas de negócio

1. Quais estados apresentam as maiores taxas de atraso, considerando uma base mínima de pedidos?
2. Pedidos atrasados recebem avaliações piores?
3. A satisfação explica a recompra dos clientes?
4. Quanto o frete pesa em relação ao preço dos itens?
5. Existe concentração relevante de valor vendido em poucos vendedores?

## Métricas exploradas

- atraso de entrega por estado, usando uma regra única baseada em timestamps;
- diferença de avaliações com tamanho de amostra e intervalo de confiança;
- taxa de recompra por cliente único;
- peso do frete por item e sobre o valor total dos itens;
- concentração do valor vendido entre vendedores.

Os valores publicados ficam em [Resultados validados](docs/resultados.md), gerados pelas queries deste repositório. A análise de entregas está detalhada no [Case Olist — atrasos de entrega e satisfação](docs/case-olist.md) e a metodologia ampliada, no [diagnóstico operacional](docs/diagnostico-operacional.md).

## Stack e fluxo de trabalho

- **Databricks** para organização do ambiente analítico e execução das consultas;
- **SQL** para agregação, análise e construção dos KPIs;
- **Delta Lake** como camada de armazenamento, demonstrada no notebook de ingestão;
- **Página web** como experiência pública de leitura e tomada de decisão.

~~~text
Dataset público → carga no Databricks → modelagem → SQL → KPIs → página pública
~~~

## Estrutura do repositório

~~~text
.
├── data/         # Origem dos dados e resultados agregados
├── notebooks/    # Notebooks SQL para execução no Databricks
├── sql/          # Queries separadas por pergunta de negócio
├── docs/         # Case, resultados e dicionário de dados
├── dashboard/    # Contexto da visualização e do dashboard técnico
└── assets/       # Recursos visuais validados, quando houver
~~~

## Como explorar o projeto

- [Página pública do diagnóstico](https://cleiton-dados.vercel.app/diagnostico-olist)
- [Resultados validados](docs/resultados.md)
- [Notebook SQL com os sete passos da análise](notebooks/01_analise_olist.sql)
- [Notebook de ingestão CSV → Delta](notebooks/00_ingestao_olist_delta.sql)
- [Taxa de atraso por estado](sql/01_atrasos_por_estado.sql)
- [Impacto do atraso nas avaliações](sql/02_impacto_do_atraso_nas_avaliacoes.sql)
- [Resumo geral de atraso](sql/07_resumo_atraso_entrega.sql)
- [Evidência estatística do impacto do atraso](sql/08_impacto_atraso_estatistica.sql)
- [Recompra de clientes](sql/03_recompra_clientes.sql)
- [Recompra versus avaliação](sql/04_recompra_por_avaliacao.sql)
- [Frete versus preço](sql/05_frete_vs_preco.sql)
- [Concentração de vendedores](sql/06_concentracao_vendedores.sql)
- [Notebook do diagnóstico ampliado](notebooks/02_diagnostico_operacional_olist.sql)
- [Dicionário de dados](docs/dicionario-de-dados.md)
- [Visualização pública e dashboard técnico](dashboard/README.md)

## Autor

**Cleiton Eugenio** — Analista de Negócios e Operações

- Portfólio: [cleiton-dados.vercel.app](https://cleiton-dados.vercel.app/)
- LinkedIn: [cleiton-eugenio-dados](https://www.linkedin.com/in/cleiton-eugenio-dados/)

---

*Dados que geram resultado.*

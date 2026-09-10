# Olist | Diagnóstico Operacional de E-commerce

> Case de análise de dados operacionais com Databricks e SQL sobre recompra, atrasos logísticos, frete e concentração de vendedores.

## Visão do case

Este projeto analisa dados públicos do e-commerce brasileiro da Olist para responder a uma pergunta relevante para operações: **quais fricções reduzem a experiência do cliente e onde a operação deve priorizar melhorias?**

O foco não é apenas descrever números. É transformar dados de pedidos e avaliações em sinais claros para priorização operacional.

## Fonte dos dados

Os dados utilizados são públicos: [Brazilian E-Commerce Public Dataset by Olist, no Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

Os arquivos brutos não são versionados aqui para manter o repositório leve. A [documentação dos dados](data/README.md) explica a origem, o escopo e como reproduzir a carga no Databricks.

## Perguntas de negócio

1. Quais estados apresentam as maiores taxas de atraso, considerando uma base mínima de pedidos?
2. Pedidos atrasados recebem avaliações piores?
3. A satisfação explica a recompra dos clientes?
4. Quanto o frete pesa em relação ao preço dos itens?
5. Existe concentração relevante de valor vendido em poucos vendedores?

## Principais achados

| Indicador | Resultado |
| --- | --- |
| Avaliação média — pedido no prazo | **4,29** |
| Avaliação média — pedido atrasado | **2,57** |
| Diferença observada | **-1,72 ponto** |
| Estados com maiores taxas na amostra | AL (23,9%), MA (19,7%), PI (16,0%) e CE (15,3%) |
| Taxa de recompra | **3,12%** dos clientes únicos |
| Frete médio | **16,6%** do preço do produto |
| Concentração de vendedores | **67,5%** do valor vendido nos 10% maiores vendedores |

O diagnóstico mostra quatro frentes de atenção: atraso regional, fricção do frete, baixa recompra e concentração comercial. Pedidos atrasados tiveram avaliação média 1,72 ponto menor, mas a comparação entre clientes que recompraram e não recompraram indica que a nota, sozinha, não explica o retorno.

Veja a análise de entregas em [Case Olist — atrasos de entrega e satisfação](docs/case-olist.md) e o [diagnóstico operacional completo](docs/diagnostico-operacional.md).

## Stack e fluxo de trabalho

- **Databricks** para organização do ambiente analítico e execução das consultas;
- **SQL** para agregação, análise e construção dos KPIs;
- **Delta Lake** como camada de dados no ambiente Databricks;
- **Página web** como camada pública de visualização do case.

~~~text
Dataset público → carga no Databricks → modelagem → SQL → KPIs → visualização
~~~

## Estrutura do repositório

~~~text
.
├── data/         # Origem dos dados e instruções de obtenção
├── notebooks/    # Notebook SQL exportável do Databricks
├── sql/          # Queries separadas por pergunta de negócio
├── docs/         # Case e dicionário de dados
├── dashboard/    # Documentação da camada de visualização pública
└── assets/       # Recursos visuais futuros
~~~

## Como explorar o projeto

- [Notebook SQL com os sete passos da análise](notebooks/01_analise_olist.sql)
- [Taxa de atraso por estado](sql/01_atrasos_por_estado.sql)
- [Impacto do atraso nas avaliações](sql/02_impacto_do_atraso_nas_avaliacoes.sql)
- [Resumo geral de atraso](sql/07_resumo_atraso_entrega.sql)
- [Recompra de clientes](sql/03_recompra_clientes.sql)
- [Recompra versus avaliação](sql/04_recompra_por_avaliacao.sql)
- [Frete versus preço](sql/05_frete_vs_preco.sql)
- [Concentração de vendedores](sql/06_concentracao_vendedores.sql)
- [Notebook do diagnóstico ampliado](notebooks/02_diagnostico_operacional_olist.sql)
- [Dicionário de dados](docs/dicionario-de-dados.md)
- [Orientação para a visualização pública](dashboard/README.md)

## Próximo passo visual

A versão pública da análise será apresentada em uma página web com identidade visual própria. O dashboard criado no Databricks permanece como evidência técnica do processo; a página web será a vitrine executiva do case.

## Autor

**Cleiton Eugenio** — Analista de Negócios e Operações

- Portfólio: [cleiton-dados.vercel.app](https://cleiton-dados.vercel.app/)
- LinkedIn: [cleiton-eugenio-dados](https://www.linkedin.com/in/cleiton-eugenio-dados/)

---

*Dados que geram resultado.*

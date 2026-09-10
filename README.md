# Databricks + SQL | Análise de Dados Operacionais

> Projeto de portfólio que transforma dados operacionais em insights acionáveis para apoiar decisões de negócio.

## Sobre o projeto

Este repositório reúne um case prático de análise de dados com **Databricks** e **SQL**, estruturado para demonstrar uma jornada completa: do dado bruto à construção de indicadores e à apresentação em dashboard.

A proposta nasce da mesma visão que orienta meu trabalho em operações: dado só tem valor quando ajuda alguém a decidir melhor, enxergar um gargalo ou agir no momento certo.

## Objetivo de negócio

- Onde estão os principais gargalos da operação?
- Quais indicadores merecem acompanhamento diário, semanal e mensal?
- Como a evolução dos KPIs pode orientar priorização e tomada de decisão?
- Como organizar um fluxo reproduzível de ingestão, tratamento e análise?

## Stack

- **Databricks** — ambiente de processamento e notebooks
- **SQL** — exploração, transformação e construção de métricas
- **Delta Lake** — organização das camadas de dados
- **Dashboard** — comunicação visual dos indicadores

## Estrutura planejada

~~~text
.
├── notebooks/        # Notebooks Databricks por etapa da análise
├── sql/              # Queries SQL organizadas por tema
├── data/
│   ├── raw/          # Amostra de dados brutos ou instruções de obtenção
│   └── processed/    # Dados tratados para análise
├── dashboard/        # Imagens, exportações e definição dos indicadores
├── docs/             # Dicionário de dados, arquitetura e decisões técnicas
└── assets/           # Recursos visuais do projeto
~~~

## Fluxo de dados

~~~text
Dados brutos → ingestão → tratamento → modelagem → consultas SQL → KPIs → dashboard
~~~

## Indicadores em foco

A seleção final de KPIs será documentada conforme o dataset, com ênfase em métricas que apoiem decisões operacionais: volume, produtividade, desempenho, tendências e possíveis desvios.

## Privacidade e reprodutibilidade

Nenhum dado confidencial será publicado. Caso o case use informações inspiradas em cenários reais, o repositório utilizará dados anonimizados, sintéticos ou agregados. As instruções de execução e o dicionário de dados ficarão em `docs/`.

## Autor

**Cleiton Eugenio** — Analista de Negócios e Operações

- Portfólio: [cleiton-dados.vercel.app](https://cleiton-dados.vercel.app/)
- LinkedIn: [cleiton-eugenio-dados](https://www.linkedin.com/in/cleiton-eugenio-dados/)

---

*Dados que geram resultado.*

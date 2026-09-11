-- Databricks notebook source
-- Carga reproduzível do Brazilian E-Commerce Public Dataset by Olist.
-- 1. Baixe os CSVs no Kaggle.
-- 2. Envie-os para um diretório acessível ao Databricks.
-- 3. Ajuste o valor abaixo para esse diretório antes de executar.

SET olist.base_path = 'dbfs:/FileStore/olist';

-- COMMAND ----------

-- Camada bronze: nove arquivos CSV originais em tabelas Delta.
CREATE OR REPLACE TABLE workspace.default.orders
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_orders_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.customers
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_customers_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.order_items
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_order_items_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.order_reviews
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_order_reviews_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.order_payments
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_order_payments_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.products
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_products_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.sellers
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_sellers_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.geolocation
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/olist_geolocation_dataset.csv`
OPTIONS (header 'true', inferSchema 'true');

CREATE OR REPLACE TABLE workspace.default.product_category_translation
USING DELTA AS
SELECT * FROM csv.`${olist.base_path}/product_category_name_translation.csv`
OPTIONS (header 'true', inferSchema 'true');

-- COMMAND ----------

-- Verificação da carga: cada tabela deve retornar ao menos uma linha.
SELECT 'orders' AS tabela, COUNT(*) AS linhas FROM workspace.default.orders
UNION ALL SELECT 'customers', COUNT(*) FROM workspace.default.customers
UNION ALL SELECT 'order_items', COUNT(*) FROM workspace.default.order_items
UNION ALL SELECT 'order_reviews', COUNT(*) FROM workspace.default.order_reviews
UNION ALL SELECT 'order_payments', COUNT(*) FROM workspace.default.order_payments
UNION ALL SELECT 'products', COUNT(*) FROM workspace.default.products
UNION ALL SELECT 'sellers', COUNT(*) FROM workspace.default.sellers
UNION ALL SELECT 'geolocation', COUNT(*) FROM workspace.default.geolocation
UNION ALL SELECT 'product_category_translation', COUNT(*) FROM workspace.default.product_category_translation;

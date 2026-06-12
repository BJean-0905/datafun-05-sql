-- sql/duckdb/case_retail_kpi_revenue.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Calculate a Key Performance Indicator (KPI) for the retail domain using DuckDB SQL.
--
-- KPI DRIVES THE WORK:
-- In analytics, we do not start with "write a query."
-- We start with a KPI that supports an actionable decision.
--
-- ACTIONABLE OUTCOME (EXAMPLE):
-- We want to identify which stores are generating the most revenue so we can:
-- - allocate staffing during high-performing periods,
-- - increase inventory for top categories,
-- - investigate why low-performing stores are underperforming,
-- - target promotions where they will have the biggest impact.
--
-- In this example, our KPI is store revenue (total sales amount) by store.
--
-- ANALYST RESPONSIBILITY:
-- Analysts are responsible for determining HOW to get the information
-- that informs the KPI and supports action.
-- That means:
-- - identifying the needed tables,
-- - joining them correctly,
-- - selecting the right measures,
-- - aggregating at the correct level (store),
-- - and presenting results in a way that supports decision-making.
--
-- ASSUMPTION:
-- We always run all commands from the project root directory.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/case_retail_kpi_revenue.sql
--   DB:   artifacts/duckdb/retail.duckdb
--
--
-- ============================================================
-- TOPIC DOMAINS + 1:M RELATIONSHIPS
-- ============================================================
-- OUR DOMAIN: RETAIL
-- Two tables in a 1-to-many relationship (1:M):
-- - shelter (1): independent/parent table
-- - adoption  (M): dependent/child table
--
-- HOW THIS RELATES TO OUR KPI:
-- - The shelter table tells us "which shelter" (shelter_id, shelter_name, city, capacity).
-- - The adoption table contains the measurable activity (adoption_id, shelter_id,animal_type, outcome,fee,date).
-- - To compute revenue by shelter, we must:
--   1) connect each adoption to its shelter (JOIN on shelter_id),
--   2) aggregate adoption fees at the shelter level (GROUP BY shelter).
--
--
-- ============================================================
-- KPI DEFINITION
-- ============================================================
-- KPI NAME: Total Revenue by Shelter
--
-- KPI QUESTION:
-- "How much revenue did each shelter generate?"
--
-- MEASURE:
-- - revenue = SUM(fee)
--
-- GRAIN (LEVEL OF DETAIL):
-- - one row per store
--
-- OUTPUT (WHAT DECISION-MAKERS NEED):
-- - store identifier and name
-- - total revenue
-- - optionally: number of sales and average sale amount
--
--
-- ============================================================
-- EXECUTION: GET THE INFORMATION THAT INFORMS THE KPI
-- ============================================================
-- Strategy:
-- - JOIN store (1) to sale (M)
-- - GROUP BY store
-- - SUM amounts to compute revenue
-- - ORDER results so we can quickly see top stores
--
SELECT
  s.shelter_id,
  s.shelter_name,
  s.city,
  s.capacity,
  COUNT(sa.adoption_id) AS adoption_count,
  ROUND(SUM(sa.fee), 2) AS total_revenue,
  ROUND(AVG(sa.fee), 2) AS avg_adoption_amount
FROM shelter AS s
JOIN adoption AS sa
  ON sa.shelter_id = s.shelter_id
GROUP BY
  s.shelter_id,
  s.shelter_name,
  s.city,
  s.capacity
ORDER BY total_revenue DESC;

-- sql/sqlite/case_retail_query_sales_aggregate.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Summarize overall sales activity across ALL stores.
--
-- This query answers:
-- - "What is our total revenue?"
-- - "What is the average sale amount?"
--
-- WHY:
-- - Establishes system-wide performance
-- - Provides a baseline before breaking results down by store
-- - Helps answer:
--   "Is overall performance up or down?"

SELECT
  COUNT(*) AS sale_count,
  '$' || printf("%.2f", SUM(amount)) AS total_revenue,
  '$' || printf("%.2f", AVG(amount)) AS avg_sale_amount
FROM sale;

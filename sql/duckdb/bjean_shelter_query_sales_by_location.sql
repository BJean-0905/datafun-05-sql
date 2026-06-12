-- sql/duckdb/bjean_shelter_query_sales_aggregate.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Summarize overall adoption activity across ALL shelters.
--
-- This query answers:
-- - "What is our total revenue?"
-- - "What is the average adoption amount?"
--
-- WHY:
-- - Establishes system-wide performance
-- - Provides a baseline before breaking results down by shelter
-- - Helps answer:
--   "Are overall adoption rates up or down?"

SELECT
  COUNT(*) AS adoption_count,
  ROUND(SUM(fee), 2) AS total_revenue,
  ROUND(AVG(fee), 2) AS avg_fee
FROM adoption;

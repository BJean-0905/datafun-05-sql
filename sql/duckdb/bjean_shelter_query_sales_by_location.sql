-- sql/duckdb/bjean_shelter_query_sales_by_location.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Summarize overall adoption activity across ALL shelters.
--
-- This query answers:
-- - "What is our total revenue by location?"
-- - "What is the average adoption amount by location?"
--
-- WHY:
-- - Establishes system-wide performance
-- - Provides an overview by location
-- - Helps answer:
--   "Are overall adoption rates up or down?"

SELECT
  shelter_id,
  COUNT(*) AS adoption_count,
  ROUND(SUM(fee), 2) AS total_revenue,
  ROUND(AVG(fee), 2) AS avg_fee
FROM adoption
GROUP BY shelter_id
ORDER BY shelter_id;

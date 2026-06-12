-- sql/sqlite/case_retail_query_sales_by_category.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Break overall sales performance down by product category.
--
-- This query answers:
-- "How many sales and how much revenue do we have by category?"
--
-- WHY:
-- - Overall totals hide important differences.
-- - Grouping lets us compare parts of the system.
-- - This often reveals where action is needed:
--   * Which categories drive revenue?
--   * Which categories underperform?
--
-- IMPORTANT:
-- This query uses GROUP BY but does NOT join tables yet.
-- We are still working only with the dependent/child table (sale).

SELECT
  product_category,
  COUNT(*) AS sale_count,
  '$' || printf("%.2f", SUM(amount)) AS total_revenue,
  '$' || printf("%.2f", AVG(amount)) AS avg_sale_amount
FROM sale
GROUP BY product_category
ORDER BY total_revenue DESC;

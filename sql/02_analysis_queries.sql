/*
  Exploratory & Analytical Queries
  Objective: Derive insights from normalized property transactions
*/

-- 1. Average Sale Price by City Segment
SELECT 
    property_split_city AS City,
    COUNT(UniqueID) AS total_transactions,
    AVG(sale_price) AS average_valuation
FROM property_transactions
GROUP BY property_split_city
ORDER BY average_valuation DESC;

-- 2. Identify Top 5% Premium Properties (Pareto Analysis Concept)
WITH ValuationCTE AS (
    SELECT 
        ParcelID,
        sale_price,
        PERCENT_RANK() OVER(ORDER BY sale_price) as pct_rank
    FROM property_transactions
)
SELECT 
    ParcelID, 
    sale_price
FROM ValuationCTE
WHERE pct_rank >= 0.95
ORDER BY sale_price DESC;

-- 3. Monthly Transaction Volume Trends
SELECT 
    YEAR(transaction_date_converted) AS SalesYear,
    MONTH(transaction_date_converted) AS SalesMonth,
    COUNT(*) AS total_sales
FROM property_transactions
GROUP BY YEAR(transaction_date_converted), MONTH(transaction_date_converted)
ORDER BY SalesYear, SalesMonth;

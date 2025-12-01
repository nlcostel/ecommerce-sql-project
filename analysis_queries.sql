-- ============================================
--   ANALYSIS QUERIES (MySQL 5.5 Compatible)
-- ============================================


-- =========================================================
-- 1. PURCHASE LIKELIHOOD RANKING  (NO CTEs / MySQL 5.5 SAFE)
-- =========================================================

SELECT
    f.customer_id,
    f.purchase_count,
    f.total_spent,
    f.days_since_purchase,
    (f.purchase_count * 0.4 + f.total_spent * 0.005 - f.days_since_purchase * 0.02)
        AS likelihood_score
FROM (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS purchase_count,
        IFNULL(SUM(oi.item_total), 0) AS total_spent,
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_purchase
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id
) AS f
ORDER BY likelihood_score DESC;



-- ============================================
-- 2. CHURN RISK SCORING (NO CTEs)
-- ============================================

SELECT
    cb.customer_id,
    cb.total_orders,
    cb.total_revenue,
    cb.days_since_last_purchase,
    CASE
        WHEN cb.days_since_last_purchase > 90 THEN 'High Risk'
        WHEN cb.days_since_last_purchase BETWEEN 31 AND 90 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS churn_risk
FROM (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS total_orders,
        SUM(oi.item_total) AS total_revenue,
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_purchase
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.customer_id
) AS cb
ORDER BY cb.days_since_last_purchase DESC;



-- ==============================================================
-- 3. REVENUE FORECAST USING SQL LINEAR REGRESSION (NO CTEs)
-- ==============================================================

SET @t := 0;

-- Step 1: Compute daily revenue
CREATE TEMPORARY TABLE daily_rev AS
SELECT
    DATE(o.order_date) AS day,
    SUM(oi.item_total) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY DATE(o.order_date)
ORDER BY day;

-- Step 2: Add increasing index `t`
CREATE TEMPORARY TABLE indexed AS
SELECT
    day,
    revenue,
    (@t := @t + 1) AS t
FROM daily_rev;

-- Step 3: Regression statistics
CREATE TEMPORARY TABLE stats AS
SELECT
    COUNT(*) AS n,
    SUM(t) AS sum_t,
    SUM(revenue) AS sum_r,
    SUM(t * revenue) AS sum_tr,
    SUM(t * t) AS sum_t2
FROM indexed;

-- Step 4: Linear regression model
CREATE TEMPORARY TABLE regression AS
SELECT
    (n * sum_tr - sum_t * sum_r) / (n * sum_t2 - sum_t * sum_t) AS slope,
    (sum_r - ((n * sum_tr - sum_t * sum_r) /
             (n * sum_t2 - sum_t * sum_t)) * sum_t) / n AS intercept
FROM stats;

-- Step 5: Forecasted revenue output
SELECT
    i.day,
    i.revenue,
    (r.slope * i.t + r.intercept) AS predicted_revenue
FROM indexed i
JOIN regression r
ORDER BY i.day;

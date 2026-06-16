USE customer_churn;

-- 1. Overall Churn Rate
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM telco_customer_churn;

-- 2. Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS total,
    SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 3. Churn by Tenure Group
SELECT 
    CASE 
        WHEN `Tenure Months` <= 12 THEN '0-1 Year'
        WHEN `Tenure Months` <= 24 THEN '1-2 Years'
        WHEN `Tenure Months` <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- 4. Churn by Internet Service
SELECT 
    `Internet Service`,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN `Churn Label` = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_customer_churn
GROUP BY `Internet Service`
ORDER BY churn_rate DESC;

-- 5. Top Churn Reasons
SELECT 
    `Churn Reason`,
    COUNT(*) AS total
FROM telco_customer_churn
WHERE `Churn Label` = 'Yes'
GROUP BY `Churn Reason`
ORDER BY total DESC
LIMIT 10;
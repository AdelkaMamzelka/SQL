SELECT 
    address,
    round(MAX(age)-MIN(age) / MAX(age), 2) AS formula, 
    round(AVG(age),2) AS average,
    CASE
        WHEN round((MAX(age) - MIN(age) / MAX(age::numeric)),2) > round(AVG(age),2) 
            THEN 'true' ELSE 'false' END comparison
FROM person
GROUP BY address
ORDER BY 1;
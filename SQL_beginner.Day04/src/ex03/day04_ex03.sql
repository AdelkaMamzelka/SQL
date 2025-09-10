SELECT DISTINCT generated_date AS missing_date
FROM v_generated_dates
LEFT JOIN person_visits AS visits 
    ON v_generated_dates.generated_date = visits.visit_date 
WHERE visits.visit_date IS NULL
ORDER BY missing_date
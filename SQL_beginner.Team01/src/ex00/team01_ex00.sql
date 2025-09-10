-- SELECT id, COALESCE("user".name, 'not defined') AS name,
--         COALESCE("user".lastname, 'not defined') AS lastname,
--         user_id, money, type, currency_id FROM "user"
-- LEFT JOIN balance ON "user".id = balance.user_id;

WITH last_rate AS (SELECT id, name, rate_to_usd AS last_rate_to_usd, updated
        FROM (SELECT *, row_number() OVER (PARTITION BY name ORDER BY updated DESC) AS lrate FROM currency)
        WHERE lrate = 1),
    sum_balance AS (SELECT user_id, SUM(COALESCE(money, 0)) AS sum_money, type, currency_id
                    FROM balance 
                    GROUP BY user_id, type, currency_id)

SELECT  COALESCE("user".name, 'not defined') AS name,
        COALESCE("user".lastname, 'not defined') AS lastname,
        type, sum_money AS volume,
        COALESCE(last_rate.name, 'not defined') AS currency_name,
        COALESCE(last_rate_to_usd, 1) AS last_rate_to_usd,
        sum_money * COALESCE(last_rate_to_usd, 1) AS total_volume_to_usd
FROM "user"
LEFT JOIN sum_balance ON "user".id = sum_balance.user_id
LEFT JOIN last_rate ON sum_balance.currency_id = last_rate.id
ORDER BY 1 DESC, 2, 3;
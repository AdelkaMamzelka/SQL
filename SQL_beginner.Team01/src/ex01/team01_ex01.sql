-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');
-- SELECT * FROM currency;

CREATE OR REPLACE FUNCTION actual_rate(p_cur_id bigint, p_date timestamp) RETURNS numeric AS $$
DeCLARE res numeric = NULL;
begin
SELECT rate_to_usd INTO res
FROM ((
        SELECT rate_to_usd,
            (currency.updated - p_date) as delta_time
        FROM currency
        WHERE currency.id = p_cur_id AND
            (currency.updated > p_date OR currency.updated = p_date)
        ORDER BY delta_time LIMIT 1)
    UNION
    (   SELECT rate_to_usd,
            (p_date - currency.updated) as delta_time
        FROM currency
        WHERE currency.id = p_cur_id AND currency.updated < p_date
        ORDER BY delta_time LIMIT 1
    )
    ORDER BY delta_time LIMIT 1) R;
return res;
end;
$$ LANGUAGE plpgsql;

WITH currency_names AS (SELECT *
        FROM (SELECT *, row_number() OVER (PARTITION BY name ORDER BY updated DESC) AS num FROM currency)
        WHERE num = 1)

SELECT  COALESCE("user".name, 'not defined') AS name,
        COALESCE("user".lastname, 'not defined') AS lastname,
        -- type, money, actual_rate(balance.currency_id, balance.updated) AS rate_to_usd,
        currency_names.name AS currency_name,
        ROUND(balance.money * COALESCE(actual_rate(balance.currency_id, balance.updated), 0), 1) AS currency_in_usd
FROM "user"
LEFT JOIN balance ON "user".id = balance.user_id
INNER JOIN currency_names ON balance.currency_id = currency_names.id
ORDER BY name DESC, lastname, currency_name;
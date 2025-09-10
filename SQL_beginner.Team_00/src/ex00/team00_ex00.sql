-- create table paths
-- ( id bigint primary key,
--   point1 varchar not null,
--   point2 varchar not null,
--   cost integer not null
--   );

-- insert into paths values (1, 'a', 'b', 10);
-- insert into paths values ((SELECT max(id)+1 from paths), 'b', 'a', 10);
-- insert into paths values ((SELECT max(id)+1 from paths), 'a', 'c', 15);
-- insert into paths values ((SELECT max(id)+1 from paths), 'c', 'a', 15);
-- insert into paths values ((SELECT max(id)+1 from paths), 'a', 'd', 20);
-- insert into paths values ((SELECT max(id)+1 from paths), 'd', 'a', 20);
-- insert into paths values ((SELECT max(id)+1 from paths), 'b', 'd', 25);
-- insert into paths values ((SELECT max(id)+1 from paths), 'd', 'b', 25);
-- insert into paths values ((SELECT max(id)+1 from paths), 'd', 'c', 30);
-- insert into paths values ((SELECT max(id)+1 from paths), 'c', 'd', 30);
-- insert into paths values ((SELECT max(id)+1 from paths), 'b', 'c', 35);
-- insert into paths values ((SELECT max(id)+1 from paths), 'c', 'b', 35);

WITH RECURSIVE nodes AS (
    SELECT point1 AS cur_path,
        point1, 
        point2, 
        cost
    FROM paths
    WHERE point1 = 'a'
    UNION
    SELECT CONCAT(nodes.cur_path, ',', paths.point1) AS cur_path,
        paths.point1, 
        paths.point2,
        nodes.cost + paths.cost
    FROM nodes
        JOIN paths ON nodes.point2 = paths.point1
    WHERE cur_path NOT LIKE CONCAT('%', paths.point1, '%')
    )
SELECT cost AS total_cost,
    CONCAT('{', cur_path, ',a}') AS tour 
FROM nodes 
WHERE LENGTH(cur_path) = 7
    AND point2 LIKE 'a'
    AND cost = (SELECT cost FROM nodes WHERE LENGTH(cur_path) = 7 AND point2 LIKE 'a' ORDER BY cost LIMIT 1)
ORDER BY total_cost, tour;
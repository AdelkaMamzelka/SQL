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
UNION
(SELECT cost AS total_cost,
    CONCAT('{', cur_path, ',a}') AS tour 
FROM nodes 
WHERE LENGTH(cur_path) = 7
    AND point2 LIKE 'a'
    AND cost = (SELECT cost FROM nodes WHERE LENGTH(cur_path) = 7 AND point2 LIKE 'a' ORDER BY cost DESC LIMIT 1))
ORDER BY total_cost, tour;
SELECT * FROM trip;

/*STEPIK(1.6)#1*/
SELECT
    name,
    city,
    per_diem,
    date_first,
    date_last
FROM trip
WHERE name LIKE '%а %'
ORDER BY date_last DESC;

/*STEPIK(1.6)#2*/
SELECT DISTINCT
    name
FROM trip
WHERE city = 'Москва'
ORDER BY name ASC;


/*STEPIK(1.6)#3*/
SELECT
    city,
    COUNT(city) AS 'Количество'
FROM trip
GROUP BY city
ORDER BY city ASC;

/*STEPIK(1.6)#4*/
SELECT
    city,
    COUNT(city) AS 'Количество'
FROM trip
GROUP BY city
ORDER BY Количество DESC
LIMIT 2;

/*STEPIK(1.6)#5*/
SELECT
    name,
    city,
    DATEDIFF(date_last, date_first) + 1 AS 'Длительность'
FROM trip
WHERE city NOT IN ('Москва', 'Санкт-Петербург')
ORDER BY Длительность DESC;

/*STEPIK(1.6)#6*/
SELECT
    name,
    city,
    date_first,
    date_last
FROM trip
WHERE DATEDIFF(date_last, date_first) IN
    (
    SELECT MIN(DATEDIFF(date_last, date_first))
    FROM trip
    );

/*STEPIK(1.6)#7*/
SELECT
    name,
    city,
    date_first,
    date_last
FROM trip
WHERE MONTH(date_first) = MONTH(date_last)
ORDER BY city, name ASC;

/*STEPIK(1.6)#8*/
SELECT
    MONTHNAME(date_first) AS 'Месяц',
    COUNT(MONTHNAME(date_first)) AS 'Количество'
FROM trip
GROUP BY Месяц
ORDER BY Количество DESC, Месяц ASC;

/*STEPIK(1.6)#9*/
SELECT
    name,
    city,
    date_first,
    /*DAY(date_first) AS 'День',*/
    (DATEDIFF(date_last, date_first) + 1) * per_diem AS 'Сумма'
FROM trip
WHERE
        MONTH(date_first) IN (2,3)
        AND
        YEAR(date_first) = 2020
ORDER BY name ASC, Сумма DESC;

/*STEPIK(1.6)#10 - ИЗМЕНЕНИЕ ДАТЫ В АТРИБУТЕ id_4 в data_last*/
UPDATE trip
SET date_last = '2020-03-02'
WHERE trip_id IN(4)
SELECT * FROM trip;

SELECT
    name,
    SUM(per_diem * (DATEDIFF(date_last, date_first) + 1)) AS 'Сумма'
FROM trip
GROUP BY name
HAVING COUNT(NAME) > 3
ORDER BY Сумма DESC;
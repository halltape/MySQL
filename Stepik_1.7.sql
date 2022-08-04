/*==================================================================================*/
                                    /*CREATING TABLE fine*/
CREATE TABLE fine(
    fine_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2),
    date_violation DATE,
    date_payment DATE
);
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'Р523ВТ','Превышение скорости(от 40 до 60)',500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111АВ','Проезд на запрещающий сигнал',1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'Т330ТТ','Превышение скорости(от 20 до 40)',500.00, '2020-01-23', '2020-02-23'),
       ('Яковлев Г.Р.', 'М701АА','Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'К892АХ','Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL),
       ('Баранов П.Е.', 'Р523ВТ','Превышение скорости(от 40 до 60)', NULL, '2020-02-14', NULL),
       ('Абрамова К.А.', 'О111АВ','Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'Т330ТТ','Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL);

/*==================================================================================*/
                                    /*CREATING TABLE traffic_violation*/
CREATE TABLE traffic_violation(
    violation_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    violation VARCHAR(50),
    sum_fine DECIMAL(8,2)
);
INSERT INTO traffic_violation(violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500.00),
       ('Превышение скорости(от 40 до 60)', 1000.00),
       ('Проезд на запрещающий сигнал', 100.00);

/*==================================================================================*/
                                    /*CREATING TABLE payment*/
CREATE TABLE payment(
    payment_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(30),
    violation VARCHAR(100),
    date_violation DATE,
    date_payment DATE
);
INSERT INTO payment(name, number_plate, violation, date_violation, date_payment)
VALUES ('Яковлев Г.Р.', 'М701АА', 'Превышение скорости(от 20 до 40)', '2020-01-12', '2020-01-22'),
       ('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', '2020-02-14', '2020-03-06'),
       ('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', '2020-03-03', '2020-03-23');

/*==================================================================================*/
                                    /*CORRECTING MISTAKES */
UPDATE traffic_violation AS tv
SET sum_fine = 1000
WHERE tv.violation_id = 3;

UPDATE fine AS f
SET f.sum_fine = NULL
WHERE f.violation = 'Проезд на запрещающий сигнал';

UPDATE fine AS f
SET f.violation = 'Проезд на запрещающий сигнал'
WHERE fine_id = 2;

UPDATE fine AS f
SET f.sum_fine = f.sum_fine / 8
WHERE f.fine_id IN(6,7);

UPDATE fine
SET fine.sum_fine = CASE fine_id
    WHEN 4 THEN 250
    WHEN 8 THEN 500
ELSE fine.sum_fine END;

/*==================================================================================*/
                                    /*MAIN QUERIES */
SELECT * FROM fine;
SELECT * FROM traffic_violation;
SELECT * FROM payment;
DROP TABLE traffic_violation;

/*==================================================================================*/
                                    /*STEPIK(1.7)#3*/
UPDATE fine AS f, traffic_violation AS tv
SET f.sum_fine = tv.sum_fine
WHERE f.sum_fine IS NULL AND f.violation = tv.violation;

/*==================================================================================*/
                                    /*STEPIK(1.7)#4*/
SELECT
    name,
    number_plate,
    violation
FROM fine
GROUP BY name, number_plate, violation
HAVING COUNT(*) >= 2
ORDER BY name, number_plate, violation ASC;

/*==================================================================================*/
                                    /*STEPIK(1.7)#5*/
UPDATE fine AS f,
    (SELECT
         name,
         number_plate,
         violation
     FROM fine
     GROUP BY name, number_plate, violation
     HAVING COUNT(*) >= 2
     ORDER BY name, number_plate, violation ASC
    ) query_in
SET f.sum_fine = f.sum_fine * 2
WHERE query_in.violation = f.violation AND
        query_in.name = f.name AND
        query_in.number_plate = f.number_plate AND
    f.date_payment IS NULL;

/*==================================================================================*/
                                    /*STEPIK(1.7)#6*/
UPDATE fine, payment
SET fine.date_payment = payment.date_payment,
    fine.sum_fine = IF(DATEDIFF(payment.date_payment, payment.date_violation) <=20,
        fine.sum_fine / 2, fine.sum_fine)
WHERE fine.name = payment.name AND
      fine.number_plate = payment.number_plate AND
      fine.violation = payment.violation AND
      fine.date_payment IS NULL;

/*==================================================================================*/
                                    /*STEPIK(1.7)#7*/
CREATE TABLE back_payment AS
    SELECT name, number_plate, violation, sum_fine, date_violation
    FROM fine
WHERE date_payment IS NULL;

SELECT * FROM back_payment;

/*==================================================================================*/
                                    /*STEPIK(1.7)#7*/
DELETE FROM fine
WHERE DATEDIFF(date_violation, '2020-02-01') < 0;
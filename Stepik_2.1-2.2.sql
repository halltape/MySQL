/*==================================================================================*/
                                    /*CREATING TABLE author*/
CREATE TABLE author(
    author_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

INSERT INTO author(name_author)
VALUES ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.');

/*==================================================================================*/
                                    /*CREATING TABLE genre*/
CREATE TABLE genre(
    genre_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

/*==================================================================================*/
                                    /*MAIN QUERIES*/
SELECT * FROM author;
SELECT * FROM genre;
SELECT * FROM book;
DROP TABLE book;

/*==================================================================================*/
                                /*CORRECTING MISTAKES */
DELETE FROM genre
WHERE genre_id IN(3,4);

UPDATE genre
SET genre_id = 3
WHERE genre_id = 5;

INSERT INTO author(name_author)
VALUES
    ('Лермонтов М.Ю.');

/*==================================================================================*/
                                    /*STEPIK(2.1)#3*/
CREATE TABLE book(
  book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(50),
  author_id INT NOT NULL,
  genre_id INT,
  price DECIMAL(8,2),
  amount INT,
  FOREIGN KEY (author_id) REFERENCES author(author_id),
  FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);
/*==================================================================================*/
                                    /*STEPIK(2.1)#4*/
CREATE TABLE book(
    book_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2),
    amount INT,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE SET NULL
);
/*==================================================================================*/
                                 /*STEPIK(2.1)#5*/
INSERT INTO book(title, author_id, genre_id, price, amount)
VALUES
    ('Мастер и Маргарита', 1, 1, 670.99, 3),
    ('Белая гвардия', 1, 1, 540.50, 5),
    ('Идиот', 2, 1, 460.00, 10),
    ('Братья Карамазовы', 2, 1, 799.01, 3),
    ('Игрок', 2, 1, 480.50, 10),
    ('Стихотворения и поэмы', 3, 2, 650.00, 15),
    ('Черный человек', 3, 2, 570.20, 6),
    ('Лирика', 4, 2, 518.99, 2);

/*==================================================================================*/
                                /*STEPIK(2.2)#1*/
SELECT
    title,
    name_genre,
    price
FROM
    genre INNER JOIN book
ON genre.genre_id = book.genre_id
WHERE book.amount > 8
ORDER BY price DESC;

/*==================================================================================*/
                                /*STEPIK(2.2)#2*/
SELECT
    name_genre
FROM genre LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE title IS NULL;

/*==================================================================================*/
                                /*STEPIK(2.2)#3*/
CREATE TABLE city(
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30)
);
INSERT INTO city(name_city)
VALUES
    ('Москва'),
    ('Санкт-Петербург'),
    ('Владивосток');
SELECT * FROM city;

SELECT
    name_city,
    name_author,
    DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY) AS 'Дата'
FROM
    city CROSS JOIN author
ORDER BY name_city ASC, Дата DESC;

/*==================================================================================*/
                                /*STEPIK(2.2)#4*/
SELECT
    name_genre,
    title,
    name_author
FROM book
    INNER JOIN genre ON genre.genre_id = book.genre_id
    INNER JOIN  author ON author.author_id = book.author_id
WHERE name_genre = 'Роман'
ORDER BY title ASC;

/*==================================================================================*/
                                /*STEPIK(2.2)#5*/
SELECT
    name_author,
    sum(amount) AS 'Количество'
FROM book
    RIGHT JOIN author on author.author_id = book.author_id
    GROUP BY name_author
    HAVING sum(amount) < 10 OR sum(amount) IS NULL
    ORDER BY Количество ASC;

/*==================================================================================*/
                                /*STEPIK(2.2)#6*/

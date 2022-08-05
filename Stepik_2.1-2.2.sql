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
DELETE FROM book
WHERE book_id = 1;

INSERT INTO genre(name_genre)
VALUES
    ('Роман'),
    ('Поэзия');

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
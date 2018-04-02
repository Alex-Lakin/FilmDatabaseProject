
DROP TABLE films_directors;
DROP TABLE films;
DROP TABLE directors;

CREATE TABLE films(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(225),
  year INT8,
  rating INT2
);

CREATE TABLE directors(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(225)
);

CREATE TABLE films_directors(
  id SERIAL8 PRIMARY KEY,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE,
  director_id INT8 REFERENCES directors(id) ON DELETE CASCADE
);

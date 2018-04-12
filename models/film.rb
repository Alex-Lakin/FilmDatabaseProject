require_relative( '../db/sql_runner' )
require_relative( 'director' )
require_relative( 'genre' )
require_relative( 'series' )

class Film
  attr_accessor :title, :year, :rating

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @year = options["year"].to_i
    @rating = options["rating"].to_i
  end

# create
  def save()
    sql = "INSERT INTO films (title, year, rating)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@title, @year, @rating]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

# read
  def self.all()
    sql = "SELECT id, title, year,
          CASE
	          WHEN(LEFT(title,2)) = 'A ' THEN SUBSTRING(title FROM 3)
	          WHEN(LEFT(title,3)) = 'An ' THEN SUBSTRING(title FROM 4)
	          WHEN(LEFT(title,4)) = 'The ' THEN SUBSTRING(title FROM 5)
	          ELSE title
	        END AS title2
          FROM films ORDER BY title2"
    result = SqlRunner.run(sql)
    return result.map{|film|Film.new(film)}
  end

  def self.find(id)
    sql = "SELECT * FROM films
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film.new(result.first)
  end

  def self.by_year(yr)
    sql = "SELECT id, title, year, rating,
          CASE
	          WHEN(LEFT(title,2)) = 'A ' THEN SUBSTRING(title FROM 3)
	          WHEN(LEFT(title,3)) = 'An ' THEN SUBSTRING(title FROM 4)
	          WHEN(LEFT(title,4)) = 'The ' THEN SUBSTRING(title FROM 5)
	          ELSE title
	        END AS title2
          FROM films WHERE year = ($1)
          ORDER BY title2"
    values = [yr]
    result = SqlRunner.run(sql,values)
    return result.map{|film|Film.new(film)}
  end

  def self.by_rating(rtng)
    sql = "SELECT id, title, year, rating,
          CASE
            WHEN(LEFT(title,2)) = 'A ' THEN SUBSTRING(title FROM 3)
            WHEN(LEFT(title,3)) = 'An ' THEN SUBSTRING(title FROM 4)
            WHEN(LEFT(title,4)) = 'The ' THEN SUBSTRING(title FROM 5)
            ELSE title
          END AS title2
          FROM films WHERE rating = ($1)
          ORDER BY title2"
      values = [rtng]
      result = SqlRunner.run(sql,values)
    return result.map{|film|Film.new(film)}
  end

  def get_directors()
    sql = "SELECT dir.* FROM directors dir
          INNER JOIN films_directors f_d
          ON f_d.director_id = dir.id
          WHERE f_d.film_id = $1
          ORDER BY name"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |dir| Director.new(dir) }
  end

  def get_genres()
    sql = "SELECT gen.* FROM genres gen
          INNER JOIN films_genres f_g
          ON f_g.genre_id = gen.id
          WHERE f_g.film_id = $1
          ORDER BY genre"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |gen| Genre.new(gen) }
  end

  def get_series()
    sql = "SELECT ser.* FROM series ser
          INNER JOIN films_series f_s
          ON f_s.series_id = ser.id
          WHERE f_s.film_id = $1
          ORDER BY name"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |ser| Series.new(ser) }
  end

  # update
  def update()
    sql = "UPDATE films
          SET (title,year,rating) = ($1,$2,$3)
          WHERE id = $4"
    values = [@title, @year, @rating,@id]
    SqlRunner.run(sql,values)
  end

  # delete
  def delete()
    sql = "DELETE FROM films
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

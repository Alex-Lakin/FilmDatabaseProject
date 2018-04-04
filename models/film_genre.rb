require_relative( '../db/sql_runner' )

class Film_Genre
  attr_accessor :film_id, :genre_id

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @genre_id = options["genre_id"]
  end
  # create
  def save()
    sql = "INSERT INTO films_genres (film_id, genre_id)
          VALUES ($1, $2)
          RETURNING id"
    values = [@film_id, @genre_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  # read
  def self.find(film_id, gen_id)
    sql = "SELECT * FROM films_genres
          WHERE film_id = $1 AND genre_id = $2"
    values = [film_id, gen_id]
    result = SqlRunner.run(sql,values)
    return Film_Genre.new(result.first)
  end

  def self.find_id(id)
    sql = "SELECT * FROM films_genres
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film_Genre.new(result.first)
  end

  # delete
  def delete()
    sql = "DELETE FROM films_genres
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

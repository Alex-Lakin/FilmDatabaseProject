require_relative( '../db/sql_runner' )
require("pry")

class Film_Director
  attr_accessor :film_id, :director_id

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @director_id = options["director_id"]
  end
  # create
  def save()
    sql = "INSERT INTO films_directors (film_id, director_id)
          VALUES ($1, $2)
          RETURNING id"
    values = [@film_id, @director_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  # read
  def self.find(film_id, dir_id)
    sql = "SELECT * FROM films_directors
          WHERE film_id = $1 AND director_id = $2"
    values = [film_id, dir_id]
    result = SqlRunner.run(sql,values)
    return Film_Director.new(result.first)
  end

  def self.find_id(id)
    sql = "SELECT * FROM films_directors
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film_Director.new(result.first)
  end

  # delete
  def delete()
    sql = "DELETE FROM films_directors
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

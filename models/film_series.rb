require_relative( '../db/sql_runner' )

class Film_Series
  attr_accessor :film_id, :series_id

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @series_id = options["series_id"]
  end

  # create
  def save()
    sql = "INSERT INTO films_series (film_id, series_id)
          VALUES ($1, $2)
          RETURNING id"
    values = [@film_id, @series_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  # read
  def self.find(film_id, ser_id)
    sql = "SELECT * FROM films_series
          WHERE film_id = $1 AND series_id = $2"
    values = [film_id, ser_id]
    result = SqlRunner.run(sql,values)
    return Film_Series.new(result.first)
  end

  def self.find_id(id)
    sql = "SELECT * FROM films_series
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film_Series.new(result.first)
  end

  # delete
  def delete()
    sql = "DELETE FROM films_series
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

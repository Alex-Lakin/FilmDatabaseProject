require_relative( '../db/sql_runner' )
require_relative( 'film' )

class Series
  attr_accessor :name

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

# create
  def save()
    sql = "INSERT INTO series (name)
          VALUES ($1)
          RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

# read
  def self.all()
    sql = "SELECT * FROM series
          ORDER BY name"
    result = SqlRunner.run(sql)
    return result.map{ |ser| Series.new(ser)}
  end

  def self.find(id)
    sql = "SELECT * FROM series
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Series.new(result.first)
  end

  def get_films()
    sql = "SELECT f.* FROM films f
          INNER JOIN films_series f_s
          ON f_s.film_id = f.id
          WHERE f_s.series_id = $1
          ORDER BY YEAR"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |film| Film.new(film) }
  end

# update
  def update()
    sql = "UPDATE series
          SET name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  # delete
  def delete()
    sql = "DELETE FROM series
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

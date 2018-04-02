require_relative( '../db/sql_runner' )
require_relative( 'film' )

class Director
  attr_accessor :name

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO directors (name)
          VALUES ($1)
          RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM directors"
    result = SqlRunner.run(sql)
    return result.map{ |dir| Director.new(dir)}
  end

  def self.find(id)
    sql = "SELECT * FROM directors
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Director.new(result.first)
  end

  def get_films()
    sql = "SELECT f.* FROM films f
          INNER JOIN films_directors f_d
          ON f_d.film_id = f.id
          WHERE f_d.director_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |film| Film.new(film) }
  end
end

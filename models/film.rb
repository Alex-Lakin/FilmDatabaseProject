require_relative( '../db/sql_runner' )
require_relative( 'director' )

class Film
  attr_accessor :title, :year, :rating

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @year = options["year"]
    @rating = options["rating"]
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
    sql = "SELECT * FROM films"
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

  def get_directors()
    sql = "SELECT dir.* FROM directors dir
          INNER JOIN films_directors f_d
          ON f_d.director_id = dir.id
          WHERE f_d.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |dir| Director.new(dir) }
  end

end

require_relative( '../db/sql_runner' )

class Film
  attr_accessor :title, :year, :rating

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @year = options["year"]
    @rating = options["rating"]
  end

  def save()
    sql = "INSERT INTO films (title, year, rating)
          VALUES ($1, $2, $3)
          RETURNING id"
    values = [@title, @year, @rating]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM films
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Film.new(result.first)
  end
end

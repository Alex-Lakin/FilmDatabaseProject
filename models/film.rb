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
    return result.first()["id"].to_i
  end
end

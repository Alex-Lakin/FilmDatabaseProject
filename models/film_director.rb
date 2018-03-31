require_relative( '../db/sql_runner' )

class Film_Director
  attr_accessor :film_id, :director_id

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @director_id = options["director_id"]
  end

  def save()
    sql = "INSERT INTO films_directors (film_id, director_id)
          VALUES ($1, $2)
          RETURNING id"
    values = [@film_id, @director_id]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end
end

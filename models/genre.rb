require_relative( '../db/sql_runner' )
require_relative( 'film' )

class Genre
  attr_accessor :genre

  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @genre = options["genre"]
  end

# create
  def save()
    sql = "INSERT INTO genre (name)
          VALUES ($1)
          RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

# read
  def self.all()
    sql = "SELECT * FROM genre
          ORDER BY genre"
    result = SqlRunner.run(sql)
    return result.map{ |gnere| Genre.new(genre)}
  end

  def self.find(id)
    sql = "SELECT * FROM genre
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Genre.new(result.first)
  end

  def get_films()
    sql = "SELECT f.* FROM films f
          INNER JOIN films_genres f_g
          ON f_g.film_id = f.id
          WHERE f_g.genre_id = $1
          ORDER BY genre"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |film| Film.new(film) }
  end

# update
  def update()
    sql = "UPDATE genres
          SET name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  # delete
  def delete()
    sql = "DELETE FROM genres
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/films_controller')
require_relative('controllers/directors_controller')
require_relative('controllers/film_directors_controller')

get '/' do
  erb( :index )
end

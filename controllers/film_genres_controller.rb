require( 'sinatra' )
require( 'sinatra/contrib/all' )if development?
require_relative( '../models/film_genre.rb' )

# posts film-genre link
post '/films_genres' do
  f_g = Film_Genre.new(params)
  f_g.save
  redirect back
end

# delete film-genre link
post '/films_genres/:id/delete' do
  f_g = Film_Genre.find_id(params['id'])
  f_g.delete
  redirect back
end

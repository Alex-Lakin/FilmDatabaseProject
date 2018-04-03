require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/film_director.rb' )

# posts film-director link
post '/films_directors' do
  f_d = Film_Director.new(params)
  f_d.save
  redirect back
end

# delete film-director link
post '/films_directors/:id/delete' do
  f_d = Film_Director.find(params['id'])
  f_d.delete
  redirect to '/films/all'
end

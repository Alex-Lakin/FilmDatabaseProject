require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/film_series.rb' )

# posts film-series link
post '/films_series' do
  f_s = Film_Series.new(params)
  f_s.save
  redirect back
end

# delete film-series link
post '/films_series/:id/delete' do
  f_s = Film_Series.find_id(params['id'])
  f_s.delete
  redirect back
end

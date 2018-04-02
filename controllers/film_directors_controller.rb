require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/director.rb' )

# posts film, director link
post '/films_directors' do
  f_d = Film_Director.new(params)
  f_d.save
  redirect to("/films/new")
end

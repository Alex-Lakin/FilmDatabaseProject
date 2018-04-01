require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/film.rb' )

get "/films/all" do
  @films = Film.all()
  erb( :"films/all" )
end

get "/films/:id" do
  @film = Film.find(params["id"].to_i)
  erb( :"films/show" )
end

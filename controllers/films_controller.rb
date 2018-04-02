require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/film.rb' )
require_relative( '../models/director.rb' )

# shows a list of all films
get "/films/all" do
  @films = Film.all()
  erb( :"films/all" )
end

# shows add new film screen
get "/films/new" do
  @director = Director.all()
  erb( :"films/new" )
end

# posts film
post '/films' do
  film = Film.new(params)
  film.save
  redirect to("/films/all")
end

# shows 1 spesific film
get "/films/:id" do
  @film = Film.find(params["id"].to_i)
  erb( :"films/show" )
end

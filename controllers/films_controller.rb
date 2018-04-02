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
  erb( :"films/new" )
end

# posts film
post '/films' do
  film = Film.new(params)
  film.save
  redirect to("/films/#{film.id}")
end

# shows edit film screen
get "/films/:id/edit" do
  @film = Film.find(params[:id].to_i)
  erb( :"films/edit" )
end

# updates with new edits
post "/films/:id" do
  film = Film.new(params)
  film.update
  redirect to "/films/#{film.id}"
end

# shows 1 specific film
get "/films/:id" do
  @film = Film.find(params["id"].to_i)
  @director = Director.all()
  erb( :"films/show" )
end

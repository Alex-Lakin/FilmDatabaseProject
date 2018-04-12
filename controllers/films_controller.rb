require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/film.rb' )
require_relative( '../models/director.rb' )
require_relative( '../models/genre.rb' )
require_relative( '../models/series.rb' )

# shows a list of all films
get "/films/all" do
  @films = Film.all()
  erb( :"films/all" )
end

# shows a list of films by year
get "/films/year/:year" do
  @films = Film.by_year(params[:year].to_i)
  p @films
  erb( :"films/year" )
end

# shows a list of films by rating
get "/films/rating/:rating" do
  @films = Film.by_rating(params[:rating].to_i)
  erb( :"films/rating" )
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
  # get particular film
  @film = Film.find(params["id"].to_i)
  # grab all directors for add directors dropdown
  @director = Director.all()
  # grab all genres for dropdown
  @genre = Genre.all()
  # grab all series for dropdown
  @series = Series.all()
  # go to films page
  erb( :"films/show" )
end

# delete film
post '/films/:id/delete' do
  film = Film.find(params['id'])
  film.delete
  redirect to '/films/all'
end

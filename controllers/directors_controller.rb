require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/director.rb' )

# shows add new director screen
get "/director/new" do
  @film_id = params['film_id']
  erb( :"director/new" )
end

# posts director
post '/directors' do
  dir = Director.new(params)
  dir.save
  redirect "/films/#{params['film_id']}"
end

# shows all the films by a specific director
get "/director/:id" do
  @director = Director.find(params["id"].to_i)
  erb( :"director/show" )
end

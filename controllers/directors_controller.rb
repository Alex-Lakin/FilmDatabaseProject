require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/director.rb' )

# shows add new director screen
get "/director/new" do
  @film_id = params['film_id']
  erb( :"director/new" )
end

# posts director
post '/director' do
  dir = Director.new(params)
  dir.save
  redirect "/films/#{params['film_id']}"
end

# shows edit directors screen
get "/director/:id/edit" do
  @director = Director.find(params[:id].to_i)
  erb( :"director/edit" )
end

# updates with new edits
post "/director/:id" do
  director = Director.new(params)
  director.update
  redirect to "/director/#{director.id}"
end

# shows all the films by a specific director
get "/director/:id" do
  @director = Director.find(params["id"].to_i)
  erb( :"director/show" )
end

# delete director
post '/director/:id/delete' do
  dir = Director.find(params['id'])
  dir.delete
  redirect to '/films/all'
end

require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/genre.rb' )

# shows add new genre screen
get "/genre/new" do
  @film_id = params['film_id']
  erb( :"genre/new" )
end

# posts genre
post '/genre' do
  gen = Genre.new(params)
  gen.save
  redirect "/films/#{params['film_id']}"
end

# shows edit genre screen
get "/genre/:id/edit" do
  @genre = Genre.find(params[:id].to_i)
  erb( :"genre/edit" )
end

# updates with new edits
post "/genre/:id" do
  gen = Genre.new(params)
  gen.update
  redirect to "/genre/#{gen.id}"
end

# shows all the films belonging to a genre
get "/genre/:id" do
  @genre = Genre.find(params["id"].to_i)
  erb( :"genre/show" )
end

# delete genre
post '/genre/:id/delete' do
  gen = Genre.find(params['id'])
  gen.delete
  redirect to '/films/all'
end

require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/series.rb' )

# shows add new series screen
get "/series/new" do
  @film_id = params['film_id']
  erb( :"series/new" )
end

# posts series
post '/series' do
  ser = Series.new(params)
  ser.save
  redirect "/films/#{params['film_id']}"
end

# shows edit seris screen
get "/series/:id/edit" do
  @series = Series.find(params[:id].to_i)
  erb( :"series/edit" )
end

# updates with new edits
post "/series/:id" do
  ser = Series.new(params)
  ser.update
  redirect to "/series/#{ser.id}"
end

# shows all the films in a franchise
get "/series/:id" do
  @series = Series.find(params["id"].to_i)
  erb( :"series/show" )
end

# delete series
post '/series/:id/delete' do
  ser = Series.find(params['id'])
  ser.delete
  redirect to '/films/all'
end

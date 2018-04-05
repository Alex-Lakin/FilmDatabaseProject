require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/series.rb' )

# shows add new series screen
get "/series/new" do
  @series_id = params['series_id']
  erb( :"series/new" )
end

# posts series
post '/series' do
  ser = Series.new(params)
  ser.save
  redirect "/series/#{params['series_id']}"
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
  redirect to "/series/#{series.id}"
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
  redirect to '/series/all'
end

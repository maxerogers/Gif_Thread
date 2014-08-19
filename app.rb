require "sinatra"
require 'sinatra/activerecord'
require 'thin'
require './config/environments' #database configuration
require './models/model'        #Model class

get "/" do
	@comments = Comment.all
	erb :index
end

post "/create_comment" do
	puts params.inspect
  Comment.create(params)
	@comments = Comment.all
	erb :index
end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end
require "sinatra"
require 'sinatra/activerecord'
require 'thin'
require './config/environments' #database configuration
require './models/model'        #Model class

get "/" do
	@comments = Comment.where(tier: 0).reverse
	erb :index
end

post "/create_comment" do
  puts params.inspect
  if (params[:id].to_i < 0)
    Comment.create(username: params[:username], data: params[:data], gif_url: params[:gif_url], tier: params[:tier])
  else
    Comment.create(username: params[:username], data: params[:data], gif_url: params[:gif_url], tier: params[:tier], parent: Comment.find(params[:id]))
  end
  
  "success"
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
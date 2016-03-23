ENV['RACK_ENV'] ||= "development"
require 'sinatra/base'
require './app/models/link'

class BookmarkManager < Sinatra::Base
  get '/' do
  end

  get '/links' do
    @links = Link.all
    erb :'/links/index'
  end

  get '/links/new' do
    erb :'/links/create_link'
  end

  post '/links' do
    Link.create title: params[:title], url: params[:url]
    redirect '/links'
  end

  run! if app_file == $0
end

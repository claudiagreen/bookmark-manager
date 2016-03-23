ENV['RACK_ENV'] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'

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
    link = Link.create(title: params[:title], url: params[:url])
    tag = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect '/links'
  end

  get '/tags/bubbles' do
    @links = Link.all(:tags => { :name => "bubbles" })
    erb :'/links/tag'
  end

  run! if app_file == $0
end

ENV['RACK_ENV'] ||= "development"
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require './app/models/link'
require './app/models/user'
require './app/models/tag'
require 'bcrypt'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  PW_ERROR = 'Password and confirmation password do not match'
  EMAIL_ERROR = 'Email address required to register'

  register Sinatra::Flash


  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
  end

  get '/links' do
    @user = User.find_user(params[:email], params[:password])
    @links = Link.all
    erb :'/links/index'
  end

  get '/links/new' do
    erb :'/links/create_link'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'/links/index'
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password],
    password_confirmation: params[:password_confirmation])
    flash.now[:error] = user.error_msgs
    unless user.id
      @email = user.email
      erb :'/users/new'
    else
      session[:user_id] = user.id
      redirect to('/links')
    end
  end

  get '/login' do
    erb :login
  end

  run! if app_file == $0
end

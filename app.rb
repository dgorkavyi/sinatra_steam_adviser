require 'sinatra/base'
require 'steam-api'
require 'sinatra'
require_relative 'helpers'

class SteamApp < Sinatra::Base
  set :root, File.dirname(__FILE__)

  helpers Sinatra::SteamApp::Helpers
  
  @@invalid_steam_id = false

  get '/' do
    erb :index
  end

  get '/suggest_game' do
    # Defaults
    steam_web_api_key = '3495AA76D910EBC50BDD1A18174E75C4'
    steam_id = params[:steam_id]

    # Set apiKey and get owned games
    Steam.apikey = steam_web_api_key

    begin
      owned_games = Steam::Player.owned_games steam_id
    rescue
      @@invalid_steam_id = true
      redirect '/'
    end
    
    @@invalid_steam_id = false
    # Sinatra

    @game_data = game_hash_data(owned_games)

    erb :suggest_game
  end
end

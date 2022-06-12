require 'sinatra/base'
require 'steam-api'
require 'sinatra'
require_relative 'helpers'

class SteamApp < Sinatra::Base
  set :root, File.dirname(__FILE__)

  helpers Sinatra::SteamApp::Helpers

  get '/game' do
    erb :index
  end

  get '/suggest_game' do
    # Defaults
    steam_web_api_key = '3495AA76D910EBC50BDD1A18174E75C4'
    steam_id = '76561198066322255'

    # Set apiKey and get owned games
    Steam.apikey = steam_web_api_key
    owned_games = Steam::Player.owned_games steam_id
    # Defaults
    steam_web_api_key = '3495AA76D910EBC50BDD1A18174E75C4'
    steam_id = '76561198066322255'

    # Set apiKey and get owned games
    Steam.apikey = steam_web_api_key
    owned_games = Steam::Player.owned_games steam_id

    # Sinatra

    @game_data = game_hash_data(owned_games)

    erb :suggest_game
  end
end

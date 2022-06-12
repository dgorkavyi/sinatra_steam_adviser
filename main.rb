# frozen_string_literal: true

require 'steam-api'
require 'pp'
require 'sinatra'
require 'json'
require_relative 'helpers'

include SteamHelpers

# Defaults
steam_web_api_key = '3495AA76D910EBC50BDD1A18174E75C4'
steam_id = '76561198066322255'

# Set apiKey and get owned games
Steam.apikey = steam_web_api_key
owned_games = Steam::Player.owned_games steam_id

# Get needed data
pp game_hash_data owned_games

# Sinatra

# game_hash_data(owned_games).to_json
get '/game' do
  erb :index
end

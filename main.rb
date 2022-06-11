require 'steam-api'
require 'pp'
require 'active_support'

# Defaults
steam_web_api_key = '3495AA76D910EBC50BDD1A18174E75C4'
steam_id = '76561198066322255'

# Ask for steam id
puts 'Do you want to set steam id ?(Y/N)'
answear = gets.chomp
print 'Enter steam id: ' if %w[y Y].include?(answear)
steam_id = gets.chomp if %w[y Y].include?(answear)

# Set apiKey and get owned games
Steam.apikey = steam_web_api_key
owned_games = Steam::Player.owned_games steam_id

# Get needed data
game_data = { name: '', played_time: '', image_url: '' }
game = owned_games['games'].to_a.sample
appid = game['appid']
game_info = Steam::Store.app_details appid
game_data[:image_url] = game_info[appid.to_s]['data']['header_image']
game_data[:name] = game_info[appid.to_s]['data']['name']
game_data[:played_time] = game['playtime_forever']

pp game_data

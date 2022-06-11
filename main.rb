# frozen_string_literal: true

require 'steam-api'
require 'pp'

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
game = owned_games['games'].sample
appid = game['appid']
game_info = Steam::Store.app_details appid
game_data[:image_url] = game_info[appid.to_s]['data']['header_image'] or ''
game_data[:name] = game_info[appid.to_s]['data']['name']
unless game['playtime_forever'].eql?(0)
  game_data[:played_time] = (game['playtime_forever'] / 60.0)
                            .truncate(2)
                            .to_s.split('.')
                            .join(' hours ')
                            .concat(' min')
else
  game_data[:played_time] = '0 hours 0 min'
end

pp game_data

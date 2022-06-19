# frozen_string_literal: true

module Sinatra
  module SteamApp
    module Helpers
      def game_url(appid)
        "https://store.steampowered.com/app/#{appid}"
      end

      def game_time(minutes)
        if minutes.eql?(0)
          '0 hours 0 min'
        else
          (minutes / 60.0)
            .truncate(2)
            .to_s.split('.')
            .join(' h ')
            .concat(' m')
        end
      end

      def game_hash_data(owned_games)
        game = owned_games['games'].sample
        appid = game['appid']
        game_info = Steam::Store.app_details appid
        data = game_info[appid.to_s]['data']

        if data.nil?
          game_hash_data owned_games
        else
          {
            game_url: game_url(appid),
            played_time: game_time(game['playtime_forever']),
            image_url: (data['header_image'] || ''),
            name: data['name']
          }
        end
      end
    end
  end
end

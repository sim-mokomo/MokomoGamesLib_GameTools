require 'json'
require_relative '../../unity/config'
require_relative '../../appcenter/config'
require_relative '../../slack/config'
require_relative '../../github/config'
require_relative '../../spreadsheets/config'
require_relative '../../playfabs/config'
require_relative '../../localize/config'
require_relative '../../store/config'

module System
  module Configs
    class Config
      # @return [Unity::Config]
      attr_reader :unity
      # @return [Store::Config]
      attr_reader :store
      # @return [Github::Config]
      attr_reader :github
      # @return [Slack::Config]
      attr_reader :slack
      # @return [AppCenter::Config]
      attr_reader :app_center
      # @return [SpreadSheet::Config]
      attr_reader :spreadsheet
      # @return [PlayFabs::Config]
      attr_reader :playfab
      # @return [Localizes::Config]
      attr_reader :localize

      def initialize(unity, store, github, slack, app_center, spreadsheet, playfab, localize)
        @unity = unity
        @store = store
        @github = github
        @slack = slack
        @app_center = app_center
        @spreadsheet = spreadsheet
        @playfab = playfab
        @localize = localize
      end

      # @return [Config]
      def self.load_config
        Config.load_from_json_file(File.join('../../apps/secret', 'config.json'))
      end

      # @return [Config]
      def self.load_from_json_file(file_path)
        File.open(file_path) do |file|
          json = JSON.parse(file.read)
          client_json = json['client']
          server_json = json['server']
          Config.new(
            Unity::Config.load_from_json(client_json['unity']),
            Store::Config.load_from_json(client_json['app']),
            Github::Config.load_from_json(json['github']),
            Slack::Config.load_from_json(json['slack']),
            AppCenter::Config.load_from_json(json['app_center']),
            SpreadSheet::Config.load_from_json(json['spreadsheet']),
            PlayFabs::Config.load_from_json(server_json['playfab']),
            Localizes::Config.load_from_json(server_json['localize'])
          )
        end
      end
    end
  end
end

require_relative 'android/config'
require_relative 'ios/config'

module Store
  class Config
    # @return [String]
    attr_reader :app_version
    # @return [String]
    attr_reader :author_email
    # @return [String]
    attr_reader :app_identifier
    # @return [Android]
    attr_reader :android
    # @return [IOS]
    attr_reader :ios

    # @param [String] app_version
    # @param [String] author_email
    # @param [String] app_identifier
    # @param [Android::Config] android
    # @param [IOS::Config] ios
    def initialize(app_version, author_email, app_identifier, android, ios)
      @app_version = app_version
      @author_email = author_email
      @app_identifier = app_identifier
      @android = android
      @ios = ios
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['app_version'],
        json['author_email'],
        json['app_identifier'],
        Android::Config.load_from_json(json['android']),
        IOS::Config.load_from_json(json['ios'])
      )
    end
  end
end

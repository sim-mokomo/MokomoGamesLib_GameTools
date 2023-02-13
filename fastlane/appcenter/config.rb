module AppCenter
  class Config
    # @return [String]
    attr_reader :organization
    # @return [String]
    attr_reader :ios_app_name
    # @return [String]
    attr_reader :android_app_name
    # @return [String]
    attr_reader :tester_group_name
    # @return [String]
    attr_reader :ios_app_token
    # @return [String]
    attr_reader :android_app_token

    def initialize(
      organization_name,
      ios_app_name,
      android_app_name,
      tester_group_name,
      ios_app_token,
      android_app_token
    )
      @organization = organization_name
      @ios_app_name = ios_app_name
      @android_app_name = android_app_name
      @tester_group_name = tester_group_name
      @ios_app_token = ios_app_token
      @android_app_token = android_app_token
    end

    # @param [Unity::Platform]
    # @return [String]
    def app_name(platform)
      app_name = ''
      case platform
      when System::Platform::IOS
        app_name = @ios_app_name
      when System::Platform::ANDROID
        app_name = @android_app_name
      else
        ''
      end

      "#{@organization}/#{app_name}"
    end

    # @param [System::Platform]
    # @return [String]
    def token(platform)
      case platform
      when System::Platform::IOS
        @ios_app_token
      when System::Platform::ANDROID
        @android_app_token
      else
        ''
      end
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['organization_name'],
        json['ios_app_name'],
        json['android_app_name'],
        json['tester_group_name'],
        json['ios_app_token'],
        json['android_app_token']
      )
    end
  end
end

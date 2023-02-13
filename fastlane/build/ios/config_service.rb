require_relative '../common/config_service'
require_relative 'config'

module Build
  module IOS
    class ConfigService < Build::Common::ConfigService
      # @param [Unity::System::Platform]
      # @param [System::Shipping]
      # @param [Integer]
      # @return [Unity::IOS::Build::Config]
      def create_config(env, build_id)
        # @type [Build::Common::Config]
        common_config = super(System::Platform::IOS, env, build_id)
        app_config = System::Configs::Config.load_config.store.ios
        ios_config = Build::IOS::Config.new(common_config)
        ios_config.provisioning_profile_name = app_config.provisioning_profile.get(env)
        ios_config.team_id = app_config.team_id
        ios_config.admob_application_id = app_config.admob_application_id
        ios_config
      end
    end
  end
end

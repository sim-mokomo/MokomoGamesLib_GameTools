require_relative '../../build/ios/provisioning_profile'

module Store
  module IOS
    class Config
      # @return [String]
      attr_reader :fastlane_password
      # @return [ProvisioningProfile]
      attr_reader :provisioning_profile
      # @return [TeamId]
      attr_reader :team_id
      # @return [String]
      attr_reader :admob_application_id
      # @return [String]
      attr_reader :store_key_id
      # @return [String]
      attr_reader :store_issuer_id
      # @return [String]
      attr_reader :store_auth_key

      def initialize(fastlane_password,
                     provisioning_profile,
                     team_id,
                     admob_application_id,
                     store_key_id,
                     store_issuer_id,
                     store_auth_key)
        @fastlane_password = fastlane_password
        @provisioning_profile = provisioning_profile
        @team_id = team_id
        @admob_application_id = admob_application_id
        @store_key_id = store_key_id
        @store_issuer_id = store_issuer_id
        @store_auth_key = store_auth_key
      end

      # @return [Config]
      def self.load_from_json(json)
        provisioning_profile_json = json['provisioning_profile']
        Config.new(
          json['fastlane_password'],
          Build::IOS::ProvisioningProfile.new(
            provisioning_profile_json['dev'],
            provisioning_profile_json['staging'],
            provisioning_profile_json['production']
          ),
          json['team_id'],
          json['admob_application_identifier'],
          json['store_key_id'],
          json['store_issuer_id'],
          json['store_auth_key']
        )
      end
    end
  end
end

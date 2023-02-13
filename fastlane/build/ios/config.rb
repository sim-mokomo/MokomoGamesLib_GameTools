module Build
  module IOS
    class Config
      # @return [Unity::Common::Build::Config]
      attr_reader :common_config
      # @return [String]
      attr_accessor :provisioning_profile_name
      # @return [String]
      attr_accessor :team_id
      # @return [String]
      attr_accessor :admob_application_id

      # @param [Unity::Common::Build::Config]
      def initialize(common_config)
        @common_config = common_config
      end
    end
  end
end

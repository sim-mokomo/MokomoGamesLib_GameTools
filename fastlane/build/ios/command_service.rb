require_relative '../common/command_service'

module Build
  module IOS
    class CommandService < Build::Common::CommandService
      private

      # @return [Unity::IOS::Build::Config]
      attr_reader :build_config

      public

      # @param [Unity::IOS::Build::Config]
      def initialize(build_config)
        super(build_config.common_config)
        @build_config = build_config
      end

      def create_command
        # @type [Commands::Command]
        command = super
        command.add_option(Commands::Unity::Option.new('provisioningProfileName', @build_config.provisioning_profile_name))
        command.add_option(Commands::Unity::Option.new('teamId', @build_config.team_id))
        command.add_option(Commands::Unity::Option.new('admob_application_identify', @build_config.admob_application_id))
        command
      end
    end
  end
end

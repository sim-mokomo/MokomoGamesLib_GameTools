require_relative '../common/process'
require_relative '../common/service'
require_relative '../common/command_service'
require_relative '../../appcenter/service'

module Build
  module Android
    class Process < Build::Common::Process
      def on_pre_build
        super

        Build::Common::Service
          .new
          .copy_build_archive_to_next(@common_build_config, Git::Utility.get_current_branch_name)
      end

      # @return [Commands::Command]
      def create_build_command
        Build::Common::CommandService.new(@common_build_config).create_command
      end

      def on_ended_build(result)
        super

        return unless @request.upload_to_appcenter

        AppCenter::Service.new.upload_app(
          @common_build_config.platform,
          @common_build_config.environment,
          ->(cmd) { @shell_executor.call(cmd) }
        )
      end
    end
  end
end

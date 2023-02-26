require_relative '../common/process'
require_relative '../common/service'
require_relative 'command_service'
require_relative '../../appcenter/service'
require_relative '../../unity/project'
require_relative '../../system/project'

module Build
  module IOS
    class Process < Build::Common::Process
      private

      # @return [Unity::IOS::Build::Config]
      attr_reader :common_build_config

      public

      # @param [Unity::IOS::Build::Config] config
      def initialize(config, request, shell_executor, execute_on_host, send_slack_message)
        super(config.common_config, request, shell_executor, execute_on_host, send_slack_message)

        @build_config = config
      end

      def on_pre_build
        super

        Build::Common::Service
          .new
          .copy_build_archive_to_next(@build_config.common_config, Git::Utility.get_current_branch_name)
      end

      # @return [Commands::Command]
      def create_build_command
        Build::IOS::CommandService.new(@build_config).create_command
      end

      # @param [Build::Common::Result] result
      def on_ended_build(result)
        super

        if result.succeeded
          # NOTE: ipaファイル作成
          fastlane_root_path = File.join(System::Project.root_path, 'tools/commons/fastlane')
          @execute_on_host.call("source ~/.zshrc && \\
                                cd #{fastlane_root_path} && \\
                                bundle install && \\
                                security unlock-keychain -p \"#{ENV.fetch('SSH_HOST_PASSWORD', nil)}\" login.keychain && \\
                                bundle exec fastlane ios xcode_build \\
                                                         env:#{@build_config.common_config.environment} \\
                                                         branch:#{Git::Utility.get_current_branch_name}")
        end

        return unless @request.upload_to_appcenter

        AppCenter::Service.new.upload_app(
          @build_config.common_config.platform,
          @build_config.common_config.environment,
          ->(cmd) { @shell_executor.call(cmd) }
        )
      end
    end
  end
end

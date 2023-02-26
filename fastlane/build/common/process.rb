require_relative '../../git/utility'
require_relative 'notify/model'
require_relative 'service'

module Build
  module Common
    class Process
      private

      # @return [Build::Common::BuildLaneRequest]
      attr_reader :request
      attr_reader :shell_executor,
                  :execute_on_host,
                  :send_slack_message
      # @return [Unity::Common::Build::Config]
      attr_reader :common_build_config

      public

      # @param [Unity::Common::Build::Config]
      # @param [Unity::BuildLaneRequest] request
      def initialize(config, request, shell_executor, execute_on_host, send_slack_message)
        @common_build_config = config
        @request = request
        @shell_executor = shell_executor
        @execute_on_host = execute_on_host
        @send_slack_message = send_slack_message
      end

      def execute
        on_pre_build
        result = build
        on_ended_build(result)
      end

      def on_pre_build; end

      # @return [Commands::Command]
      def create_build_command; end

      # @return [Build::Common::Result]
      def build
        Build::Common::Service
          .new
          .build(
            @common_build_config.platform,
            create_build_command,
            ->(cmd) { @execute_on_host.call(cmd) }
          )
      end

      def on_ended_build(result)
        return unless @request.enable_notify

        notify_model = Build::Common::Notify::Model.new
        notify_model.notify_unity_build(
          result,
          lambda { |title, success, payload|
            @send_slack_message.call(title, success, payload)
          }
        )
      end
    end
  end
end

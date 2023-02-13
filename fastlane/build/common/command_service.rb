require_relative '../../system/command/command'
require_relative '../../system/command/custom_option'

module Build
  module Common
    class CommandService
      private

      # @return [Build::Common::Config]
      attr_reader :common_build_config

      public

      def initialize(build_config)
        @common_build_config = build_config
      end

      # @return [Array<System::Command::Option>]
      def self.create_command_options(execute_method_name)
        [
          System::Command::Option.new('-quit', System::Extensions::String.empty_string),
          System::Command::Option.new('-batchmode', System::Extensions::String.empty_string),
          System::Command::Option.new('-nographics', System::Extensions::String.empty_string),
          System::Command::Option.new('-projectPath', Unity::Project.new(Unity::Project::Env.new)),
          System::Command::Option.new('-executeMethod', execute_method_name)
        ]
      end

      # @return [System::Command::Command]
      def create_command
        options = Build::Common::CommandService.create_command_options('MokomoGames.Editor.Builds.Process.BuildFromCui')
        options.push(System::Command::CustomOption.new('environment', @common_build_config.environment))
        options.push(System::Command::CustomOption.new('version', @common_build_config.app_version))
        options.push(System::Command::CustomOption.new('productName', @common_build_config.product_name))
        options.push(System::Command::CustomOption.new('output_path', @common_build_config.output_path))
        options.push(System::Command::CustomOption.new('platform', @common_build_config.platform))
        options.push(System::Command::CustomOption.new('app_id', @common_build_config.app_id))
        command = System::Command::Command.new(
          Unity::App.host_app_path(@common_build_config.version),
          options
        )
        unless @common_build_config.build_id.nil?
          command.add_option(System::Command::CustomOption.new('build_id', @common_build_config.build_id.to_s))
        end

        command
      end
    end
  end
end

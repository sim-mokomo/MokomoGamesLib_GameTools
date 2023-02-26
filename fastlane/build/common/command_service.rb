require_relative '../../commands/command'
require_relative '../../commands/unity/option'
require_relative '../../system/project'
require_relative '../../unity/service'
require_relative '../../extensions/string'

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

      # @return [Array<Commands::Option>]
      def self.create_command_options(execute_method_name)
        [
          Commands::Option.new('-quit', Extensions::String.empty_string),
          Commands::Option.new('-batchmode', Extensions::String.empty_string),
          Commands::Option.new('-nographics', Extensions::String.empty_string),
          Commands::Option.new('-projectPath', Unity::Project.new(System::Project.root_path).root_path),
          Commands::Option.new('-executeMethod', execute_method_name)
        ]
      end

      # @return [Commands::Command]
      def create_command
        options = Build::Common::CommandService.create_command_options('MokomoGames.Editor.Builds.Process.BuildFromCui')
        options.push(Commands::Unity::Option.new('environment', @common_build_config.environment))
        options.push(Commands::Unity::Option.new('version', @common_build_config.app_version))
        options.push(Commands::Unity::Option.new('productName', @common_build_config.product_name))
        options.push(Commands::Unity::Option.new('output_path', @common_build_config.output_path))
        options.push(Commands::Unity::Option.new('platform', @common_build_config.platform))
        options.push(Commands::Unity::Option.new('app_id', @common_build_config.app_id))
        command = Commands::Command.new(
          Unity::Service.machine_app_path(@common_build_config.version),
          options
        )

        unless @common_build_config.build_id.nil?
          command.add_option(Commands::Unity::Option.new('build_id', @common_build_config.build_id.to_s))
        end

        command
      end
    end
  end
end

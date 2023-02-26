module System
  module Command
    class Command
      # @return [String]
      attr_reader :command_path

      # @return [Array<BuildCommandOption>]
      attr_reader :options

      # @param [String] command_path
      # @param [Array<BuildCommandOption>] options
      def initialize(command_path, options)
        @command_path = command_path
        @options = options
      end

      # @param [BuildCommandOption] option
      def add_option(option)
        @options.push(option)
      end
    end
  end
end

module System
  module Command
    class Command
      # @return [String]
      attr_reader :execute_key

      # @return [Array<BuildCommandOption>]
      attr_reader :options

      # @param [String] execute_key
      # @param [Array<BuildCommandOption>] options
      def initialize(execute_key, options)
        @execute_key = execute_key
        @options = options
      end

      # @param [BuildCommandOption] option
      def add_option(option)
        @options.push(option)
      end
    end
  end
end

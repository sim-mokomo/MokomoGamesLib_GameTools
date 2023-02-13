require_relative 'command'

module System
  module Command
    class Parser
      OPTION_PREFIX = 'option:'.freeze
      # @param [Array<BuildCommand>] commands
      def parse(commands)
        command_string = ''
        commands.each do |command|
          command_string += "#{command.execute_key} "

          command.options.each do |option|
            command_string += "#{option.key} "
            command_string += "#{option.parameter} " unless option.parameter.empty?
          end
        end

        command_string.strip
      end
    end
  end
end

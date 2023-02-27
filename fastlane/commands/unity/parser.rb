require_relative '../command'

module Commands
  module Unity
    class Parser
      # @param [Array<BuildCommand>] commands
      def parse(commands)
        command_string = ''
        commands.each do |command|
          command_string += "#{command.command_path} "

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

require_relative '../common/process'

module Build
  module Linux
    class Process < Build::Common::Process
      def create_build_command
        command = super
        command.add_option(Commands::Option.new('headlessMode', true))
      end
    end
  end
end

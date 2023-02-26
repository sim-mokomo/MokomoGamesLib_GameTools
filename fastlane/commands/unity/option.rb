require_relative '../option'

module Commands
  module Unity
    class Option < Commands::Option
      OPTION_PREFIX = 'option:'.freeze

      def initialize(key, parameter)
        super("#{OPTION_PREFIX}#{key}", parameter)
      end
    end
  end
end

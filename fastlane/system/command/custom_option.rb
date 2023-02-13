require_relative 'option'

module System
  module Command
    class CustomOption < Option
      OPTION_PREFIX = 'option:'.freeze
      def initialize(key, parameter)
        super("#{OPTION_PREFIX}#{key}", parameter)
      end
    end
  end
end

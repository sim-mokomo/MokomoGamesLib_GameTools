module Commands
  class Option
    attr_reader :key
    # @return [String]
    attr_reader :parameter

    def initialize(key, parameter)
      @key = key
      @parameter = parameter
    end
  end
end

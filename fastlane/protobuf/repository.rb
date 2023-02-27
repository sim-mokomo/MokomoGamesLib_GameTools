module ProtoBuf
  class Repository
    # @param [String] message_root_path
    def initialize(message_root_path)
      # @type [String]
      @message_root_path = message_root_path
    end

    # @return [Array<String>]
    def message_path_list
      Dir.glob(File.expand_path("#{@message_root_path}/**/*.proto")).sort!
    end
  end
end

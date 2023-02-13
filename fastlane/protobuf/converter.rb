module ProtoBuf
  class Converter
    # @param [String] message_root_path
    # @param [String] output_path
    # @param [String] message_file
    # @return [Boolean]
    def self.convert(message_root_path, output_path, message_file)
      system("protoc -I=#{message_root_path} --csharp_out=#{output_path} #{message_file}") == true
    end
  end
end

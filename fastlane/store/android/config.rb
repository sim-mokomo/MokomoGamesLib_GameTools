module Store
  module Android
    class Config
      # @return [Integer]
      attr_reader :version_code
      # @return [String]
      attr_reader :store_api_key_file_name

      def initialize(version_code, api_key_filename)
        @version_code = version_code
        @store_api_key_file_name = api_key_filename
      end

      # @return [Config]
      def self.load_from_json(json)
        Config.new(
          json['version_code'],
          json['store_api_key_file_name']
        )
      end
    end
  end
end

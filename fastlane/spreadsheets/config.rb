module SpreadSheet
  class Config
    # @return [String]
    attr_reader :api_key_file_name

    def initialize(api_key_file_name)
      @api_key_file_name = api_key_file_name
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['api_key_file_name']
      )
    end
  end
end

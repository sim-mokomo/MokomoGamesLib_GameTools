module Localizes
  class Config
    # @return [String]
    attr_reader :spreadsheet_id
    # @return [String]
    attr_reader :table_name

    def initialize(spreadsheet_id, table_name)
      @spreadsheet_id = spreadsheet_id
      @table_name = table_name
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['spreadsheet_id'],
        json['table_name']
      )
    end
  end
end

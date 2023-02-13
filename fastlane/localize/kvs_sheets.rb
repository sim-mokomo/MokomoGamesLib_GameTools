require_relative '../google_api/factory'

module Localized
  class KVSSheet
    attr_reader :sheets_api_service
    # @return [String]
    attr_reader :sheet_name
    # @return [String]
    attr_reader :spreadsheet_id

    class Record
      # @return [String]
      attr_reader :key
      # @return [String]
      attr_reader :value

      def initialize(key, value)
        @key = key
        @value = value
      end
    end

    def initialize(spreadsheet_id, sheet_name)
      @sheets_api_service = GoogleApi::Factory.create_api_service
      @spreadsheet_id = spreadsheet_id
      @sheet_name = sheet_name
    end

    # @return [Array<KVSSheet::Record>]
    def load_records
      keys = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R2C1:C1")
      words = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R2C2:C2")

      # @type [Array<KVSSheet::Record>]
      records = []
      keys.values.each_index do |i|
        records.push(Record.new(keys.values[i][0], words.values[i][0]))
      end

      records
    end
  end
end

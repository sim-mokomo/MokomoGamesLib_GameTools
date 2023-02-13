require 'google/apis/sheets_v4'
require_relative '../system/platform'
require_relative '../google_api/factory'
require_relative 'localize_type'

module Localized
  class LocalizeTableRecord
    class WordRecord
      # @return [Localized::LanguageType]
      attr_reader :language_type
      # @return [String]
      attr_reader :word

      # @param [Localized::LanguageType]
      # @param [String]
      def initialize(language_type, word)
        @language_type = language_type
        @word = word
      end
    end

    # @return [String]
    attr_reader :key
    # @return [Array<WordRecord>]
    attr_reader :word_records

    # @param [String]
    # @param [Array<WordRecord>]
    def initialize(key, word_records)
      @key = key
      @word_records = word_records
    end

    # @return [WordRecord]
    def word(language)
      record = @word_records.find { |x| x.language_type == language }
      if record.nil?
        WordRecord.new(language, '') if record.nil?
      else
        record
      end
    end
  end

  class LocalizedSheet
    attr_reader :sheets_api_service
    # @return [String]
    attr_reader :sheet_name
    # @return [String]
    attr_reader :spreadsheet_id

    def initialize(spreadsheet_id, sheet_name)
      @sheets_api_service = GoogleApi::Factory.create_api_service
      @spreadsheet_id = spreadsheet_id
      @sheet_name = sheet_name
    end

    # @param [Array<String>] languages
    # @return [String]
    def uniq_characters_all(languages)
      languages.inject('') { |result, item| result + get_uniq_characters(item) }
    end

    # @param [Localized::LanguageType]
    def get_uniq_characters(language)
      words = words_from_language(language)
      words
        .inject { |result, item| result + item }
        .chars
        .uniq
        .inject { |result, item| result + item }
    end

    # @param [Localized::LanguageType]
    def get_string_pairs_all(language)
      [keys, words_from_language(language)]
    end

    # @return [Array<LocalizeTableRecord>]
    def load_records
      header = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R1C1:R1").values[0]

      # @type [Array<LocalizeTableRecord>]
      localized_table = []
      keys.each_with_index do |key, index|
        record_index = index + 2
        record_range = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R#{record_index}C1:R#{record_index}")
        records = record_range.values.flatten
        # @type [Array<LocalizeTableRecord::WordRecord>]
        words = []
        Localized::LanguageType.all.each do |lang|
          header_index = header.find_index { |value| value == lang }
          word = LocalizeTableRecord::WordRecord.new(lang, records[header_index])
          words.push(word)
        end

        localized_table.push(LocalizeTableRecord.new(key, words))
      end
      localized_table
    end

    # @param [Localized::LanguageType]
    def keys
      @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R2C1:C1").values.flatten
    end

    # @param [Localized::LanguageType]
    # @return [Array<String>]
    def words_from_language(language)
      header = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R1C1:R1")
      header_index = header.values[0].find_index { |value| value == language }
      words = @sheets_api_service.get_spreadsheet_values(@spreadsheet_id, "#{@sheet_name}!R2C#{header_index + 1}:C#{header_index + 1}")
      words.values.flatten
    end
  end
end

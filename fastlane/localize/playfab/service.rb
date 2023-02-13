require_relative '../localize_sheet'
require_relative './api'

module Localize
  module PlayFab
    class Service
      def update_string_table_all(spreadsheet_id, sheet_name, project_id, secret_key)
        send_values = []
        Localized::LanguageType.all.each do |lang|
          (keys, words) = Localized::LocalizedSheet.new(spreadsheet_id, sheet_name)
                                                   .get_string_pairs_all(lang)
          data = {
            '_keys' => keys,
            '_values' => words
          }

          table_name = Localized::LanguageType.string_table_name(lang)
          send_values.push(::PlayFab::KeyValue.new(table_name, JSON.generate(data)))
        end

        ::PlayFab::API.set_title_data(send_values, secret_key, project_id)
      end
    end
  end
end

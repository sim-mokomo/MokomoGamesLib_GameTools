require_relative '../../../localize/localize_sheet'
require_relative 'repository'

module Store
  module Android
    module Metadata
      class Service
        def download(spreadsheet_id)
          # NOTE: ローカライズ必須アプリ設定の書き出し
          records = Localized::LocalizedSheet.new(spreadsheet_id, 'GooglePlayStoreLocalizedConfig').load_records
          Localized::LanguageType.all.each do |lang|
            records.each do |record|
              Store::Android::Metadata::Repository.new.save(lang, record.key, record.word(lang).word)
            end
          end
        end
      end
    end
  end
end

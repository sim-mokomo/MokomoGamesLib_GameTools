require_relative '../../../localize/localize_sheet'
require_relative '../../../localize/kvs_sheets'
require_relative 'repository'

module Store
  module IOS
    module Metadata
      class Service
        def download(spreadsheet_id)
          # NOTE: ローカライズ必須アプリ設定の書き出し
          records = Localized::LocalizedSheet.new(spreadsheet_id, 'AppStoreLocalizedConfig').load_records
          app_store_repository = Store::IOS::Metadata::Repository.new
          Localized::LanguageType.all.each do |lang|
            records.each do |record|
              app_store_repository.save_metadata_file(lang, record.key, record.word(lang).word)
            end
          end

          # NOTE: アプリ設定の書き出し
          Localized::KVSSheet
            .new(spreadsheet_id, 'AppStoreNonLocalizedConfig')
            .load_records.each do |record|
            app_store_repository.save_non_localized_app_conf(record.key, record.value)
          end

          # NOTE: レビュー設定の書き出し
          Localized::KVSSheet
            .new(spreadsheet_id, 'AppStoreNonLocalizedReviewConfig')
            .load_records.each do |record|
            app_store_repository.save_review_config(record.key, record.value)
          end
        end
      end
    end
  end
end

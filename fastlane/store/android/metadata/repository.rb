require_relative '../../../system/configs/config'

module Store
  module Android
    module Metadata
      class Repository
        # @param [Localized::LanguageType]
        # @param [String]
        # @param [String]
        def save(lang, filename, file_content)
          dir_path = create_metadata_dir_path(lang, filename)
          FileUtils.makedirs(dir_path)
          File.write(File.join(dir_path, create_metadata_filename(filename)), file_content)
        end

        # @return [String]
        def get_api_key_file_path
          config = System::Configs::Config.load_config
          File.expand_path("./store/android/#{config.client.app.android.store_api_key_file_name}")
        end

        # @return [String]
        def get_root_dir_path
          File.expand_path('./store/android/metadata/')
        end

        private

        # @return [String]
        def create_metadata_dir_path(lang, filename)
          if filename == 'changelogs'
            File.join(get_root_dir_path, lang_to_folder_name(lang), 'changelogs')
          else
            File.join(get_root_dir_path, lang_to_folder_name(lang))
          end
        end

        def create_metadata_filename(filename)
          if filename == 'changelogs'
            'default.txt'
          else
            "#{filename}.txt"
          end
        end

        # @return [String]
        def lang_to_folder_name(lang)
          {
            Localized::LanguageType::ARABIC => 'ar',
            Localized::LanguageType::ENGLISH => 'en-US',
            Localized::LanguageType::KOREAN => 'ko-KR',
            Localized::LanguageType::JAPANESE => 'ja-JP',
            Localized::LanguageType::SIMPLIFIED_CHINESE_CHARACTERS => 'zh-CN',
            Localized::LanguageType::TRADITIONAL_CHINESE_CHARACTERS => 'zh-TW'
          }[lang]
        end
      end
    end
  end
end

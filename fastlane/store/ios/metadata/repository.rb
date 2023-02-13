module Store
  module IOS
    module Metadata
      class Repository
        def save_metadata_file(lang, filename, content)
          dir_path = File.join(get_metadata_root_dir_path, lang_to_metadata_folder_name(lang))
          FileUtils.makedirs(dir_path)
          File.write(File.join(dir_path, "#{filename}.txt"), content)
        end

        def save_non_localized_app_conf(key, value)
          dir_path = File.join(get_metadata_root_dir_path)
          FileUtils.makedirs(dir_path)
          File.write(File.join(dir_path, "#{key}.txt"), value)
        end

        def save_review_config(key, value)
          dir_path = File.join(get_metadata_root_dir_path, 'review_information/')
          FileUtils.makedirs(dir_path)
          File.write(File.join(dir_path, "#{key}.txt"), value)
        end

        def get_metadata_root_dir_path
          File.expand_path('./store/ios/metadata')
        end

        def get_screenshots_root_dir_path
          File.expand_path('./store/ios/screenshots')
        end

        private

        def lang_to_metadata_folder_name(lang)
          table = {
            Localized::LanguageType::ARABIC => 'ar-SA',
            Localized::LanguageType::ENGLISH => 'en-US',
            Localized::LanguageType::KOREAN => 'ko',
            Localized::LanguageType::JAPANESE => 'ja',
            Localized::LanguageType::SIMPLIFIED_CHINESE_CHARACTERS => 'zh-Hans',
            Localized::LanguageType::TRADITIONAL_CHINESE_CHARACTERS => 'zh-Hant'
          }
          table[lang]
        end
      end
    end
  end
end

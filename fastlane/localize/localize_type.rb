module Localized
  module LanguageType
    JAPANESE = 'Japanese'.freeze # 日本語
    ARABIC = 'Arabic'.freeze # アラビア語
    ENGLISH = 'English'.freeze # 英語US
    SIMPLIFIED_CHINESE_CHARACTERS = 'SimplifiedChineseCharacters'.freeze # 簡体字
    TRADITIONAL_CHINESE_CHARACTERS = 'TraditionalChineseCharacters'.freeze # 繁体字
    KOREAN = 'Korean'.freeze # 韓国語

    def self.all
      constants.map { |name| const_get(name) }.sort
    end

    # @param [Localized::LanguageType]
    def self.string_table_name(type)
      "StringTable_#{type}"
    end
  end
end

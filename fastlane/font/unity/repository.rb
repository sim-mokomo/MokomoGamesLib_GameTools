require_relative '../../localize/localize_sheet'
require_relative '../../unity/project'
require_relative '../../system/project'

module Font
  module Unity
    class Repository
      # @param [String]
      # @param [String]
      # @param [String] file_name
      # @param [Array<System::LanguageType>]
      def download_characters_file(spreadsheet_id, table_name, file_name, languages)
        File.open(File.join(::Unity::Project.new(System::Project.root_path).assets_path,
                            'MokomoGames/Localization/Fonts/CharacterList',
                            file_name), 'w') do |file|
          characters = Localized::LocalizedSheet.new(spreadsheet_id, table_name).uniq_characters_all(languages)
          file.write(characters)
        end
      end
    end
  end
end

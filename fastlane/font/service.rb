require_relative './unity/repository'
require_relative '../commands/command'
require_relative '../system/configs/config'
require_relative '../unity/service'

module Font
  class Service
    private

    attr_reader :shell_executor_on_host

    public

    def initialize(shell_executor_on_host)
      @shell_executor_on_host = shell_executor_on_host
    end

    # @param [System::Platform]
    def create_unity_assets
      command = Commands::Command.new(
        ::Unity::Service.machine_app_path(System::Configs::Config.load_config.unity.version),
        ::Build::Common::CommandService.create_command_options('MokomoGames.Font.Editor.FontAssetCreatorWindow.GenerateFontAtlasAllFromEditor')
      )

      command_str = Commands::Unity::Parser.new.parse([command])
      @shell_executor_on_host.call(command_str)
    end

    # @param [String]
    # @param [String]
    def download_characters_file_all(spreadsheet_id, table_name)
      repository = Font::Unity::Repository.new
      repository.download_characters_file(spreadsheet_id, table_name, 'CharacterList_SC.txt', [Localized::LanguageType::SIMPLIFIED_CHINESE_CHARACTERS])
      repository.download_characters_file(spreadsheet_id, table_name, 'CharacterList_TC.txt', [Localized::LanguageType::TRADITIONAL_CHINESE_CHARACTERS])
      repository.download_characters_file(spreadsheet_id, table_name, 'Characterlist_AR.txt', [Localized::LanguageType::ARABIC])
      repository.download_characters_file(spreadsheet_id, table_name, 'Characterlist_KR.txt', [Localized::LanguageType::KOREAN])
      repository.download_characters_file(spreadsheet_id, table_name, 'CharcterList_OTHER.txt', [Localized::LanguageType::JAPANESE, Localized::LanguageType::ENGLISH])
    end
  end
end

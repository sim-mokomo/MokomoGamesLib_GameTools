require_relative '../git/utility'
require_relative '../system/configs/config'

module AppCenter
  class Service
    private

    # @param [System::Platform]
    # @param [String]
    # @return [String]
    def create_upload_command(platform, app_path)
      app_center_config = System::Configs::Config.load_config.app_center
      "appcenter distribute release \\
            --app #{app_center_config.app_name(platform)} \\
            --file #{app_path} \\
            --group #{app_center_config.tester_group_name} \\
            --token #{app_center_config.token(platform)}"
    end

    public

    # @param [System::Shipping]
    # @note アプリをAppCenterにアップロードする
    def upload_app(platform, env, shell_executor)
      current_branch = Git::Utility.get_current_branch_name
      project_name = System::Configs::Config.load_config.unity.project_name

      case platform
      when System::Platform::ANDROID
        aab_path = ArchivesCreator.create_android.get_latest_aab_file_path(false, project_name, current_branch, env)
        shell_executor.call(create_upload_command(platform, aab_path))
      when System::Platform::IOS
        ipa_path = ArchivesCreator.create_ios.get_latest_ipa_file_path(false, project_name, current_branch, env)
        shell_executor.call(create_upload_command(platform, ipa_path))
      else
        throw 'Error: サポートされていないプラットフォームです'
      end
    end
  end
end

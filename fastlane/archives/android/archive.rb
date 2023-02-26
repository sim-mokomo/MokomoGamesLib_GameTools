require_relative '../archive'

module Archives
  module Android
    class Archive < Archives::Archive
      # @param [Boolean]
      # @param [String]
      # @param [String]
      # @param [System::Shipping]
      # @return [String]
      def latest_aab_file_path(is_host, project_name, branch_name, env)
        archive_id = latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::ANDROID)
        File.join(
          platform_dir_path(is_host, project_name, branch_name, env, archive_id, System::Platform::ANDROID),
          'game.aab'
        )
      end
    end
  end
end

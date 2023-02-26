require_relative '../archive'

module Archives
  module IOS
    class Archive < Archives::Archive
      # @param [Boolean] is_host
      # @param [String] project_name
      # # @param [String] branch_name
      # @param [String] env
      # @return [String]
      def latest_xcworkspace_path(is_host, project_name, branch_name, env)
        File.join(latest_ipa_dir(is_host, project_name, branch_name, env), 'Unity-iPhone.xcworkspace')
      end

      # @param [Boolean] is_host
      # @param [String] project_name
      # # @param [String] branch_name
      # @param [String] env
      # @return [String]
      def latest_xcodeproj_path(is_host, project_name, branch_name, env)
        File.join(latest_ipa_dir(is_host, project_name, branch_name, env), 'Unity-iPhone.xcodeproj')
      end

      def latest_ipa_dir(is_host, project_name, branch_name, env)
        archive_id = latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::IOS)
        ipa_dir(is_host, project_name, branch_name, env, archive_id)
      end

      # @param [Boolean]
      # @param [String]
      # @param [String]
      # @param [System::Shipping]
      # @return [String]
      def latest_ipa_file_path(is_host, project_name, branch_name, env)
        File.join(latest_ipa_dir(is_host, project_name, branch_name, env), 'game.ipa')
      end

      private

      # @param [Boolean] is_host
      # @param [String] project_name
      # @param [String] env
      # @param [Integer] archive_id
      # @return [String]
      def ipa_dir(is_host, project_name, branch_name, env, archive_id)
        File.join(platform_dir_path(is_host, project_name, branch_name, env, archive_id, System::Platform::IOS), 'game')
      end
    end
  end
end

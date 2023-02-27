require_relative '../../git/utility'
require_relative '../../system/configs/config'
require_relative 'metadata/repository'

module Store
  module IOS
    class Service
      def upload(env, deliver_lane)
        config = System::Configs::Config.load_config
        metadata_repository = Store::IOS::Metadata::Repository.new
        ipa_path = Archives::IOS::Archive.new
                                         .latest_ipa_file_path(
                                           true,
                                           config.client.unity.project_name,
                                           Git::Utility.get_current_branch_name,
                                           env
                                         )
        app_config = config.client.app
        deliver_lane.call(
          ipa_path,
          app_config.author_email,
          app_config.app_identifier,
          app_config.app_version.to_s,
          metadata_repository.get_metadata_root_dir_path,
          metadata_repository.get_screenshots_root_dir_path
        )
      end
    end
  end
end

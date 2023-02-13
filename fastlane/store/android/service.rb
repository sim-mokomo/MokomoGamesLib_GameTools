require_relative '../../git/utility'
require_relative '../../system/configs/config'
require_relative '../../system/archives_creator'
require_relative './metadata/repository'

module Store
  module Android
    class Service
      def upload(env, supply_lane)
        config = System::Configs::Config.load_config
        metadata_repository = Store::Android::Metadata::Repository.new
        supply_lane.call(
          config.client.app.app_identifier,
          ArchivesCreator
           .create_android
           .get_latest_aab_file_path(
             false,
             config.client.unity.project_name,
             Git::Utility.get_current_branch_name,
             env
           ),
          config.client.app.android.version_code,
          env != System::Shipping::PRODUCTION,
          metadata_repository.get_api_key_file_path,
          metadata_repository.get_root_dir_path
        )
      end
    end
  end
end

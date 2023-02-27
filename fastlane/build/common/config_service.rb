require_relative '../../system/configs/config'
require_relative '../../git/utility'
require_relative '../../archives/archive'
require_relative 'config'

module Build
  module Common
    class ConfigService
      # @param [Unity::System::Platform]
      # @param [System::Shipping]
      # @param [Integer]
      # @return [Unity::Common::Build::Config]
      def create_config(platform, env, build_id)
        config = System::Configs::Config.load_config
        unity = config.unity
        project_name = unity.project_name

        build_config = Build::Common::Config.new
        build_config.version = unity.version
        build_config.project_name = project_name
        build_config.product_name = unity.product_name
        build_config.environment = env
        build_config.platform = platform
        build_config.app_version = config.store.app_version
        build_config.app_id = config.store.app_identifier

        cur_branch_name = Git::Utility.get_current_branch_name
        archives = Archives::Archive.new
        build_config.build_id = build_id || (archives.latest_archive_id(false, project_name, cur_branch_name, env) + 1)
        build_config.output_path = archives.platform_dir_path(true, project_name, cur_branch_name, env, build_config.build_id, platform)
        build_config
      end
    end
  end
end

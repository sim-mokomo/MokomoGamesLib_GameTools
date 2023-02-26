require_relative '../../git/utility'
require_relative './xcode'
require_relative '../../system/configs/config'

module Build
  module IOS
    class Service
      def xcode_build(env, current_branch, gym_lane)
        archives = Archives::IOS::Archive.new
        project_name = System::Configs::Config.load_config.unity.project_name

        is_host = true
        xcode_workspace_path = archives.latest_xcworkspace_path(is_host, project_name, current_branch, env)
        latest_ipa_dir = archives.latest_ipa_dir(is_host, project_name, current_branch, env)

        xcode = Build::IOS::Xcode.new
        gym_request = {}
        if File.exist?(xcode_workspace_path)
          gym_request[:workspace] = xcode_workspace_path
        else
          gym_request[:project] = archives.latest_xcodeproj_path(is_host, project_name, current_branch, env)
        end
        gym_request[:configuration] = xcode.get_configuration(env)
        gym_request[:scheme] = xcode.get_scheme
        gym_request[:output_directory] = latest_ipa_dir
        gym_request[:output_name] = 'game'
        gym_request[:include_bitcode] = false
        gym_request[:include_symbols] = false
        gym_request[:export_method] = xcode.get_export_method(env)

        FileUtils.remove_file(latest_ipa_dir, force: true)
        gym_lane.call(gym_request)
      end
    end
  end
end

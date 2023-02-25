require_relative '../system/platform'

module Unity
  class Service
    # @param [String]
    # @return [String]
    def self.machine_app_path(unity_version)
      platform = System::Platform.machine_platform
      Unity::App.app_path(platform, unity_version)
    end
  end
end

require_relative '../system/platform'

module Unity
  class App
    # @param [Platform] machine_platform
    # @param [String] unity_version
    # @return [String]
    def self.app_path(machine_platform, unity_version)
      case machine_platform
      when System::Platform::IOS, System::Platform::MAC_OS
        "/Applications/Unity/Hub/Editor/#{unity_version}/Unity.app/Contents/MacOS/Unity"
      when System::Platform::ANDROID, System::Platform::WINDOWS
        "/c/PROGRA~1/Unity/Hub/Editor/#{unity_version}/Editor/Unity.exe"
      else
        raise 'ビルド対応していないプラットフォームが渡されました。'
      end
    end

    def self.host_app_path(unity_version)
      return app_path(System::Platform::WINDOWS, unity_version) if System::Platform.host_is_windows?
      return app_path(System::Platform::MAC_OS, unity_version) if System::Platform.host_is_macos?
    end
  end
end

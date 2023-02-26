module System
  module Platform
    # NOTE: 値の扱いを統一するために、UnityにおけるプラットフォームEnum値を元にしている。
    NONE = ''.freeze
    IOS = 'iOS'.freeze
    ANDROID = 'Android'.freeze
    WINDOWS = 'StandaloneWindows64'.freeze
    MAC_OS = 'StandaloneOSX'.freeze
    LINUX = 'StandaloneLinux64'.freeze

    PLATFORM_KEY = 'PLATFORM'.freeze

    # @return [Array<String>]
    def self.all_platforms
      [
        Platform::IOS,
        Platform::ANDROID,
        Platform::WINDOWS,
        Platform::MAC_OS,
        Platform::LINUX
      ]
    end

    # @return [System::Platform]
    def self.machine_platform
      ENV.fetch(PLATFORM_KEY, '')
    end
  end
end

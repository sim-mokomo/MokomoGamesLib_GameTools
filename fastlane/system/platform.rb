module System
  module Platform
    # NOTE: 値の扱いを統一するために、UnityにおけるプラットフォームEnum値を元にしている。
    NONE = ''.freeze
    IOS = 'iOS'.freeze
    ANDROID = 'Android'.freeze
    WINDOWS = 'StandaloneWindows64'.freeze
    MAC_OS = 'StandaloneOSX'.freeze
    LINUX = 'StandaloneLinux64'.freeze

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

    # @param [System::Platform]
    # @return [Boolean]
    def self.host_platform_is?(platform)
      ENV['PLATFORM'] == platform
    end

    # @return [Boolean]
    def self.host_is_windows?
      host_platform_is?(System::Platform::ANDROID) ||
        host_platform_is?(System::Platform::WINDOWS)
    end

    # @return [Boolean]
    def self.host_is_macos?
      host_platform_is?(System::Platform::IOS) ||
        host_platform_is?(System::Platform::MAC_OS)
    end

    # @return [Boolean]
    def self.host_is_linux?
      host_platform_is?(System::Platform::LINUX)
    end
  end
end

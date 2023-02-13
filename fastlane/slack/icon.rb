require_relative '../system/platform'

class SlackIcon
  def self.get_platform_icon(platform)
    table = [
      { platform: System::Platform::IOS, icon: ':apple-icon:' },
      { platform: System::Platform::ANDROID, icon: ':android:' },
      { platform: System::Platform::WINDOWS, icon: ':windows:' },
      { platform: System::Platform::MAC_OS, icon: ':mac-os-logo:' },
      { platform: System::Platform::LINUX, icon: ':penguin:' }
    ]

    icon = table.find { |x| x[:platform] == platform }
    icon[:icon]
  end

  def self.get_result_status_icon(result_status)
    result_status ? ':ok:' : ':boom:'
  end
end

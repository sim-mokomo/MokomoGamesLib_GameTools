require_relative '../../slack/icon'
require_relative '../../system/platform'

describe SlackIcon do
  describe '#get_platform_icon' do
    it 'iOSを指定した時にリンゴアイコンが取得できるか' do
      icon_name = SlackIcon.get_platform_icon(System::Platform::IOS)
      expect(icon_name).to eq ':apple-icon:'
    end

    it 'Androidを指定した時にAndroidアイコンが取得できるか' do
      icon_name = SlackIcon.get_platform_icon(System::Platform::ANDROID)
      expect(icon_name).to eq ':android:'
    end

    it 'Windowsを指定した時にWindowsアイコンが取得できるか' do
      icon_name = SlackIcon.get_platform_icon(System::Platform::WINDOWS)
      expect(icon_name).to eq ':windows:'
    end

    it 'macOSを指定した時にMacOSアイコンが取得できるか' do
      icon_name = SlackIcon.get_platform_icon(System::Platform::MAC_OS)
      expect(icon_name).to eq ':mac-os-logo:'
    end
  end

  describe '#get_result_status_icon' do
    it 'trueの場合にOKアイコンが取得できるか' do
      icon_name = SlackIcon.get_result_status_icon(true)
      expect(icon_name).to eq ':ok:'
    end

    it 'falseの場合にNGアイコンが取得できるか' do
      icon_name = SlackIcon.get_result_status_icon(false)
      expect(icon_name).to eq ':boom:'
    end
  end
end

require_relative '../../unity/app'
require_relative '../../system/platform'

module Unity
  describe App do
    it 'Windowsプラットフォームのアプリパスが取得できるか' do
      app_path = App.app_path(System::Platform::WINDOWS, '2020.3.30f1')
      expect(app_path).to eq '/c/PROGRA~1/Unity/Hub/Editor/2020.3.30f1/Editor/Unity.exe'
    end

    it 'iOSプラットフォームのアプリパスが取得できるか' do
      app_path = App.app_path(System::Platform::IOS, '2020.3.30f1')
      expect(app_path).to eq '/Applications/Unity/Hub/Editor/2020.3.30f1/Unity.app/Contents/MacOS/Unity'
    end

    it 'Macプラットフォームのアプリパスが取得できるか' do
      app_path = App.app_path(System::Platform::MAC_OS, '2020.3.30f1')
      expect(app_path).to eq '/Applications/Unity/Hub/Editor/2020.3.30f1/Unity.app/Contents/MacOS/Unity'
    end

    it 'Androidプラットフォームのアプリパスが取得できるか' do
      app_path = App.app_path(System::Platform::ANDROID, '2020.3.30f1')
      expect(app_path).to eq '/c/PROGRA~1/Unity/Hub/Editor/2020.3.30f1/Editor/Unity.exe'
    end
  end
end

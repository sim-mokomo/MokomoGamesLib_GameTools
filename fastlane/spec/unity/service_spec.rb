require_relative '../../system/platform'
require_relative '../../unity/service'

module Unity
  describe Service do
    describe 'machine_app_path' do
      it 'Windows指定の場合に、Windowsが前提のUnityアプリパスが返ってくること' do
        allow(ENV).to receive(:fetch).with(System::Platform::PLATFORM_KEY, '').and_return(System::Platform::WINDOWS)
        app_path = Unity::Service.machine_app_path('2021.3.8f1')
        expect(app_path).to eq '/c/PROGRA~1/Unity/Hub/Editor/2021.3.8f1/Editor/Unity.exe'
      end

      it 'MacOS指定の場合に、MacOSが前提のUnityアプリパスが返ってくること' do
        allow(ENV).to receive(:fetch).with(System::Platform::PLATFORM_KEY, '').and_return(System::Platform::MAC_OS)
        app_path = Unity::Service.machine_app_path('2021.3.8f1')
        expect(app_path).to eq '/Applications/Unity/Hub/Editor/2021.3.8f1/Unity.app/Contents/MacOS/Unity'
      end

      it 'Android指定の場合に、Windowsが前提のUnityアプリパスが返ってくること' do
        allow(ENV).to receive(:fetch).with(System::Platform::PLATFORM_KEY, '').and_return(System::Platform::ANDROID)
        app_path = Unity::Service.machine_app_path('2021.3.8f1')
        expect(app_path).to eq '/c/PROGRA~1/Unity/Hub/Editor/2021.3.8f1/Editor/Unity.exe'
      end

      it 'iOS指定の場合に、MacOSが前提のUnityアプリパスが返ってくること' do
        allow(ENV).to receive(:fetch).with(System::Platform::PLATFORM_KEY, '').and_return(System::Platform::IOS)
        app_path = Unity::Service.machine_app_path('2021.3.8f1')
        expect(app_path).to eq '/Applications/Unity/Hub/Editor/2021.3.8f1/Unity.app/Contents/MacOS/Unity'
      end
    end
  end
end

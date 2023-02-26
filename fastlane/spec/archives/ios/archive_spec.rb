require_relative '../../../archives/ios/archive'
require_relative '../../../system/shipping'

module Archives
  describe 'Archive' do
    describe 'latest_ipa_dir' do
      it '最新アーカイブのipaディレクトリが取得できることを確認' do
        allow(ENV)
          .to receive(:fetch)
          .with(Archives::Archive.docker_archive_root_path_key, '')
          .and_return('./commons/fastlane/spec/archives/fixtures/archive/ios/latest_ipa_dir/最新アーカイブのipaディレクトリが取得できることを確認')
        archive = Archives::IOS::Archive.new
        path = archive.latest_ipa_dir(false, 'ProjectName', 'BranchName', System::Shipping::DEV)
        expect(path).to eq './commons/fastlane/spec/archives/fixtures/archive/ios/latest_ipa_dir/最新アーカイブのipaディレクトリが取得できることを確認/ProjectName/BranchName/Development/3/iOS/game'
      end
    end
  end
end

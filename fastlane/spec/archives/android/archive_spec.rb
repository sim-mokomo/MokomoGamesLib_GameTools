require_relative '../../../archives/android/archive'
require_relative '../../../system/shipping'

module Archives
  describe 'Archive' do
    describe 'latest_aab_file_path' do
      it '最新アーカイブのaabファイルパスが取得できる事を確認' do
        allow(ENV)
          .to receive(:fetch)
          .with(Archives::Archive.docker_archive_root_path_key, '')
          .and_return('./commons/fastlane/spec/archives/fixtures/archive/android/latest_aab_file_path/最新アーカイブのaabファイルパスが取得できる事を確認')
        archive = Archives::Android::Archive.new
        path = archive.latest_aab_file_path(false, 'ProjectName', 'BranchName', System::Shipping::DEV)
        expect(path).to eq './commons/fastlane/spec/archives/fixtures/archive/android/latest_aab_file_path/最新アーカイブのaabファイルパスが取得できる事を確認/ProjectName/BranchName/Development/3/Android/game.aab'
      end
    end
  end
end

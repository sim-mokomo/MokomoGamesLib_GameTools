require_relative '../../archives/service'
require_relative '../../system/shipping'
require_relative '../../system/platform'

module Archives
  describe 'Service' do
    describe 'copy_archive_to_next_archive' do
      it '前回のアーカイブが次回アーカイブ向けにコピーできていることを確認' do
        allow(ENV)
          .to receive(:fetch)
          .with(Archives::Archive.docker_archive_root_path_key, '')
          .and_return('./commons/fastlane/spec/archives/fixtures/service/copy_archive_to_next_archive/前回のアーカイブが次回アーカイブ向けにコピーできていることを確認')
        FileUtils.rm_r('./commons/fastlane/spec/archives/fixtures/service/copy_archive_to_next_archive/前回のアーカイブが次回アーカイブ向けにコピーできていることを確認/ProjectName/BranchName/Development/3')
        Archives::Service.copy_archive_to_next_archive(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          System::Platform::IOS
        )
        File.exist?('./commons/fastlane/spec/archives/fixtures/service/copy_archive_to_next_archive/前回のアーカイブが次回アーカイブ向けにコピーできていることを確認/ProjectName/BranchName/Development/3/iOS/game/test2.txt')
      end
    end
  end
end

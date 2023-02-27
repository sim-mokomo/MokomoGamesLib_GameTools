require_relative '../../archives/archive'
require_relative '../../system/shipping'

describe 'Archives' do
  describe 'root_path' do
    it '(Dockerコンテナ)アーカイブルートパスが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.docker_archive_root_path_key, '').and_return('/archives')
      expect(Archives::Archive.new.root_path(false)).to eq '/archives'
    end

    it '(ホストマシン)アーカイブルートパスが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.host_archive_root_path_key, '').and_return('/host_archives')
      expect(Archives::Archive.new.root_path(true)).to eq '/host_archives'
    end
  end

  describe 'env_dir_path' do
    it '(Dockerコンテナ)環境別のアーカイブパスを取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.docker_archive_root_path_key, '').and_return('/archives')
      expect(Archives::Archive.new.env_dir_path(false, 'ProjectName', 'BranchName', System::Shipping::DEV))
        .to eq '/archives/ProjectName/BranchName/Development'
    end

    it '(ホストマシン)環境別のアーカイブパスを取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.host_archive_root_path_key, '').and_return('/host_archives')
      expect(Archives::Archive.new.env_dir_path(true, 'ProjectName', 'BranchName', System::Shipping::DEV))
        .to eq '/host_archives/ProjectName/BranchName/Development'
    end
  end

  describe 'archive_dir_path' do
    it '(Dockerコンテナ)適当なビルドIDを指定した場合に、ビルドIDのルートを示すパスが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.docker_archive_root_path_key, '').and_return('/archives')
      expect(Archives::Archive.new.archive_dir_path(false, 'ProjectName', 'BranchName', System::Shipping::DEV, 1))
        .to eq '/archives/ProjectName/BranchName/Development/1'
    end

    it '(ホストマシン)適当なビルドIDを指定した場合に、ビルドIDのルートを示すパスが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.host_archive_root_path_key, '').and_return('/host_archives')
      expect(Archives::Archive.new.archive_dir_path(true, 'ProjectName', 'BranchName', System::Shipping::DEV, 1))
        .to eq '/host_archives/ProjectName/BranchName/Development/1'
    end
  end

  describe 'platform_dir_path' do
    it '(Dockerコンテナ)プラットフォーム別のアーカイブフォルダルートが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.docker_archive_root_path_key, '').and_return('/archives')
      expect(Archives::Archive.new.platform_dir_path(false, 'ProjectName', 'BranchName', System::Shipping::DEV, 1, System::Platform::ANDROID))
        .to eq '/archives/ProjectName/BranchName/Development/1/Android'
    end

    it '(ホストマシン)プラットフォーム別のアーカイブフォルダルートが取得できるか' do
      allow(ENV).to receive(:fetch).with(Archives::Archive.host_archive_root_path_key, '').and_return('/host_archives')
      expect(Archives::Archive.new.platform_dir_path(true, 'ProjectName', 'BranchName', System::Shipping::DEV, 1, System::Platform::IOS))
        .to eq '/host_archives/ProjectName/BranchName/Development/1/iOS'
    end
  end

  describe 'latest_archive_id' do
    it '複数のアーカイブから最新のアーカイブIDを取得できることを確認' do
      allow(ENV)
        .to receive(:fetch)
        .with(Archives::Archive.docker_archive_root_path_key, '')
        .and_return('./commons/fastlane/spec/archives/fixtures/archive/latest_archive_id/複数のアーカイブから最新のアーカイブIDを取得できることを確認')
      archive = Archives::Archive.new
      expect(archive.latest_archive_id(false, 'ProjectName', 'BranchName', System::Shipping::DEV))
        .to eq 3
    end
  end

  describe 'latest_platform_archive_id' do
    it '指定したプラットフォームパス内の最新のアーカイブIDを返すか確認' do
      allow(ENV)
        .to receive(:fetch)
        .with(Archives::Archive.docker_archive_root_path_key, '')
        .and_return('./commons/fastlane/spec/archives/fixtures/archive/latest_platform_archive_id/指定したプラットフォームパス内の最新のアーカイブIDを返すか確認')
      archives = Archives::Archive.new
      expect(archives.latest_platform_archive_id(false, 'ProjectName', 'BranchName', System::Shipping::DEV, System::Platform::IOS))
        .to eq 2
    end
  end
end

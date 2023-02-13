require_relative '../../system/archives'
require_relative '../../system/shipping'

class DummyEnv
  include Archives::IEnv
  def archive_root_path(is_host)
    is_host ? '/host_archives' : '/archives'
  end
end

describe 'Archives' do
  describe '#to_root_path' do
    it '(Dockerコンテナ)アーカイブルートパスが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(archives.to_root_path(false)).to eq '/archives'
    end

    it '(ホストマシン)アーカイブルートパスが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(archives.to_root_path(true)).to eq '/host_archives'
    end
  end

  describe '#to_env_dir_path' do
    it '(Dockerコンテナ)環境別のアーカイブパスを取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_env_dir_path(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV
        )
      ).to eq '/archives/ProjectName/BranchName/Development'
    end

    it '(ホストマシン)環境別のアーカイブパスを取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_env_dir_path(
          true,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV
        )
      ).to eq '/host_archives/ProjectName/BranchName/Development'
    end
  end

  describe '#to_archive_id_dir_path' do
    it '(ホストマシン)適当なビルドIDを指定した場合に、ビルドIDのルートを示すパスが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_archive_id_dir_path(
          true,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          1
        )
      ).to eq '/host_archives/ProjectName/BranchName/Development/1'
    end

    it '(Dockerコンテナ)適当なビルドIDを指定した場合に、ビルドIDのルートを示すパスが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_archive_id_dir_path(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          1
        )
      ).to eq '/archives/ProjectName/BranchName/Development/1'
    end
  end

  describe '#to_archive_platform_dir_path' do
    it '(ホストマシン)プラットフォーム別のアーカイブフォルダルートが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_platform_dir_path(
          true,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          1,
          System::Platform::IOS
        )
      ).to eq '/host_archives/ProjectName/BranchName/Development/1/iOS'
    end

    it '(Dockerコンテナ)プラットフォーム別のアーカイブフォルダルートが取得できるか' do
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.to_platform_dir_path(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          1,
          System::Platform::ANDROID
        )
      ).to eq '/archives/ProjectName/BranchName/Development/1/Android'
    end
  end

  describe '#get_archive_id_list' do
    it 'アーカイブIDリストを配列で取得できているか確認' do
      archives = Archives.new(DummyEnv.new)
      expect(archives.get_archive_id_list('./spec/fixtures/archive/get_archive_id_list')).to eq [1, 2, 3]
    end
  end

  describe '#get_latest_archive_id' do
    it '指定したパスにディレクトリが存在しない場合にid:0を返すか確認' do
      class DummyFileSystem
        def get_children(_path)
          %w[1 2 3 4]
        end

        def exists_dir(_path)
          false
        end
      end
      archives = Archives.new(DummyEnv.new)

      expect(
        archives.get_latest_archive_id(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV
        )
      ).to eq 0
    end

    it '指定したパス内のアーカイブIDリストが空の場合にID:0を返すか確認' do
      class DummyFileSystem
        def get_children(_path)
          %w[]
        end

        def exists_dir(_path)
          true
        end
      end
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.get_latest_archive_id(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV
        )
      ).to eq 0
    end
  end

  describe '#get_latest_platform_archive_id' do
    it '指定したパスにディレクトリが存在しない場合にid:0を返すか確認' do
      class DummyFileSystem
        def get_children(_path)
          %w[1 2 3 4]
        end

        def exists_dir(_path)
          false
        end
      end
      archives = Archives.new(DummyEnv.new)

      expect(
        archives.get_latest_platform_archive_id(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          System::Platform::IOS
        )
      ).to eq 0
    end

    it '指定したパス内のアーカイブIDリストが空の場合にID:0を返すか確認' do
      class DummyFileSystem
        def get_children(_path)
          %w[]
        end

        def exists_dir(_path)
          true
        end
      end
      archives = Archives.new(DummyEnv.new)
      expect(
        archives.get_latest_platform_archive_id(
          false,
          'ProjectName',
          'BranchName',
          System::Shipping::DEV,
          System::Platform::IOS
        )
      ).to eq 0
    end
  end

  describe '#aab_file_path' do
    it '(Dockerコンテナ)指定したaabファイルパスが取得できるか確認' do
      archives = AndroidArchives.new(DummyEnv.new)
      aab_file_path = archives.aab_file_path(
        false,
        'ProjectName',
        'BranchName',
        System::Shipping::DEV,
        1
      )
      expect(aab_file_path).to eq '/archives/ProjectName/BranchName/Development/1/Android/game.aab'
    end
  end
end

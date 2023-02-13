require_relative 'platform'

class Archives
  module IEnv
    def archive_root_path(_is_host)
      raise 'Not Implemented'
    end
  end

  class Env
    include IEnv

    # @param [Boolean]
    # @return [String]
    def archive_root_path(is_host)
      # @type [String]
      env_archive_root_path = ENV.fetch('TO_HOST_BUILD_ROOT_PATH', '')
      if is_host && env_archive_root_path.length.positive?
        return env_archive_root_path
      end

      '/archives'
    end
  end

  # @return [Env]
  attr_reader :env

  def initialize(env)
    @env = env
  end

  # @param [Boolean] is_host
  # @return [String]
  def to_root_path(is_host)
    @env.archive_root_path(is_host)
  end

  # ProjectName/BranchName/Environment/BuildNo/Platform
  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] branch_name
  # @return [String]
  def to_branch_dir_path(is_host, project_name, branch_name)
    File.join(to_root_path(is_host), project_name, branch_name)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] branch_name
  # @param [String] env
  # @return [String]
  def to_env_dir_path(is_host, project_name, branch_name, env)
    File.join(to_branch_dir_path(is_host, project_name, branch_name), env)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] branch_name
  # @param [String] env
  # @param [Integer] build_id
  def to_archive_id_dir_path(is_host, project_name, branch_name, env, build_id)
    File.join(to_env_dir_path(is_host, project_name, branch_name, env), build_id.to_s)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] branch_name
  # @param [Shipping] env
  # @param [Integer] build_id
  # @param [String] platform
  def to_platform_dir_path(is_host, project_name, branch_name, env, build_id, platform)
    File.join(to_archive_id_dir_path(is_host, project_name, branch_name, env, build_id), platform)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] branch_name
  # @param [Shipping] env
  # @param [Proc] proc
  # @return [Integer]
  def get_latest_archive_id(is_host, project_name, branch_name, env, proc = nil)
    env_path = to_env_dir_path(is_host, project_name, branch_name, env)
    return 0 unless Dir.exist?(env_path)

    archive_id_list = get_archive_id_list(env_path)
    return 0 if archive_id_list.empty?

    archive_id_list = archive_id_list.select do |id|
      if proc.nil?
        true
      else
        proc.call(id)
      end
    end

    return 0 if archive_id_list.empty?

    archive_id_list.sort!
    archive_id_list.reverse!
    archive_id_list[0]
  end

  # @param [String] path
  # @return [Array<Integer>]
  def get_archive_id_list(path)
    Dir.open(path) do |d|
      children = d.children
      return children.map(&:to_i)
    end
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] env
  # @param [String] platform
  # @return [Integer]
  def get_latest_platform_archive_id(is_host, project_name, branch_name, env, platform)
    get_latest_archive_id(is_host, project_name, branch_name, env, lambda { |id|
      Dir.exist?(to_platform_dir_path(is_host, project_name, branch_name, env, id.to_i, platform))
    })
  end

  # @param [Boolean]
  # @param [String]
  # @param [String]
  # @param [Shipping]
  # @param [String]
  # @param [Integer]
  def copy_build_archive_to_next_archive(is_host, project_name, branch_name, env, platform, build_id)
    archives = ArchivesCreator.create

    latest_build_id = archives.get_latest_platform_archive_id(
      is_host,
      project_name,
      branch_name,
      env,
      platform
    )
    platform_archive_exists = latest_build_id.positive?
    return unless platform_archive_exists

    # NOTE: 保存先のディレクトリ作成
    next_build_id_path = archives.to_archive_id_dir_path(
      is_host,
      project_name,
      branch_name,
      env,
      build_id
    )
    FileUtils.mkdir_p(next_build_id_path)

    latest_archive_dir_path = archives.to_platform_dir_path(
      is_host,
      project_name,
      branch_name,
      env,
      latest_build_id,
      platform
    )

    next_archive_dir_path = archives.to_platform_dir_path(
      is_host,
      project_name,
      branch_name,
      env,
      build_id,
      platform
    )

    `cp -r #{latest_archive_dir_path} #{next_archive_dir_path}`
  end
end

# TODO: ファイルを分ける
class IOSArchives < Archives
  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [Shipping] env
  # @param [Integer] archive_id
  # @return [String]
  def xcode_workspace_path(is_host, project_name, branch_name, env, archive_id)
    "#{ios_output_dir(is_host, project_name, branch_name, env, archive_id)}/Unity-iPhone.xcworkspace"
  end

  def get_latest_xcode_workspace_path(is_host, project_name, branch_name, env)
    archive_id = get_latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::IOS)
    xcode_workspace_path(is_host, project_name, branch_name, env, archive_id)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [Shipping] env
  # @param [Integer] archive_id
  # @return [String]
  def xcode_project_path(is_host, project_name, branch_name, env, archive_id)
    "#{ios_output_dir(is_host, project_name, branch_name, env, archive_id)}/Unity-iPhone.xcodeproj"
  end

  def get_latest_xcode_project_path(is_host, project_name, branch_name, env)
    archive_id = get_latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::IOS)
    xcode_project_path(is_host, project_name, branch_name, env, archive_id)
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] env
  # @param [Integer] archive_id
  # @return [String]
  def ios_output_dir(is_host, project_name, branch_name, env, archive_id)
    "#{ArchivesCreator
        .create
        .to_platform_dir_path(
          is_host,
          project_name,
          branch_name,
          env,
          archive_id,
          System::Platform::IOS
        )}/game"
  end

  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] env
  # @param [Integer] archive_id
  # @return [String]
  def ipa_path(is_host, project_name, branch_name, env, archive_id)
    File.join(
      ios_output_dir(is_host, project_name, branch_name, env, archive_id),
      'game.ipa'
    )
  end

  def get_latest_ipa_dir(is_host, project_name, branch_name, env)
    archive_id = get_latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::IOS)
    ios_output_dir(is_host, project_name, branch_name, env, archive_id)
  end

  # @param [Boolean]
  # @param [String]
  # @param [String]
  # @param [System::Shipping]
  # @return [String]
  def get_latest_ipa_file_path(is_host, project_name, branch_name, env)
    archive_id = get_latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::IOS)
    ipa_path(is_host, project_name, branch_name, env, archive_id)
  end
end

# TODO: ファイルを分ける
class AndroidArchives < Archives
  # @param [Boolean] is_host
  # @param [String] project_name
  # @param [String] env
  # @param [Integer] build_id
  def aab_file_path(is_host, project_name, branch_name, env, build_id)
    android_archive_path = to_platform_dir_path(
      is_host,
      project_name,
      branch_name,
      env,
      build_id,
      System::Platform::ANDROID
    )
    "#{android_archive_path}/game.aab"
  end

  # @param [Boolean]
  # @param [String]
  # @param [String]
  # @param [System::Shipping]
  # @return [String]
  def get_latest_aab_file_path(is_host, project_name, branch_name, env)
    archive_id = get_latest_platform_archive_id(is_host, project_name, branch_name, env, System::Platform::ANDROID)
    aab_file_path(is_host, project_name, branch_name, env, archive_id)
  end
end

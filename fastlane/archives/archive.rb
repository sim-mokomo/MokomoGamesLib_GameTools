require_relative '../system/platform'

module Archives
  class Archive
    HOST_ARCHIVE_ROOT_PATH_KEY = 'TO_HOST_BUILD_ROOT_PATH'.freeze
    DOCKER_ARCHIVE_ROOT_PATH_KEY = 'TO_HOST_BUILD_ROOT_PATH'.freeze

    # @return [String]
    def self.host_archive_root_path_key
      HOST_ARCHIVE_ROOT_PATH_KEY
    end

    def self.docker_archive_root_path_key
      DOCKER_ARCHIVE_ROOT_PATH_KEY
    end

    # @param [Boolean] is_host
    # @return [String]
    def root_path(is_host)
      is_host ? ENV.fetch(HOST_ARCHIVE_ROOT_PATH_KEY, '') : ENV.fetch(DOCKER_ARCHIVE_ROOT_PATH_KEY, '')
    end

    # @param [Boolean] is_host
    # @param [String] project_name
    # @param [String] branch_name
    # @param [String] env
    # @return [String]
    def env_dir_path(is_host, project_name, branch_name, env)
      to_branch_dir_path = File.join(root_path(is_host), project_name, branch_name)
      File.join(to_branch_dir_path, env)
    end

    # @param [Boolean] is_host
    # @param [String] project_name
    # @param [String] branch_name
    # @param [String] env
    # @param [Integer] archive_id
    def archive_dir_path(is_host, project_name, branch_name, env, archive_id)
      File.join(env_dir_path(is_host, project_name, branch_name, env), archive_id.to_s)
    end

    # @param [Boolean] is_host
    # @param [String] project_name
    # @param [String] branch_name
    # @param [Shipping] env
    # @param [Integer] archive_id
    # @param [String] platform
    def platform_dir_path(is_host, project_name, branch_name, env, archive_id, platform)
      File.join(archive_dir_path(is_host, project_name, branch_name, env, archive_id), platform)
    end

    # @param [Boolean] is_host
    # @param [String] project_name
    # @param [String] branch_name
    # @param [Shipping] env
    # @param [Proc] condition
    # @return [Integer]
    def latest_archive_id(is_host, project_name, branch_name, env, condition = nil)
      env_dir_path = env_dir_path(is_host, project_name, branch_name, env)
      unless Dir.exist?(env_dir_path)
        p("環境別のディレクトリが存在していません env_dir_path:#{env_dir_path}")
        return 0
      end

      id_list = []
      Dir.open(env_dir_path) do |dir|
        id_list = dir.children.map(&:to_i)
      end
      if id_list.empty?
        p("環境別のディレクトリ以下に、アーカイブが一つもありませんでした。 env_dir_path: #{env_dir_path}")
        return 0
      end

      unless condition.nil?
        id_list = id_list.select { |id| condition.call(id) }
      end

      id_list.sort!
      id_list.reverse!
      id_list[0]
    end

    # @param [Boolean] is_host
    # @param [String] project_name
    # @param [String] env
    # @param [String] platform
    # @return [Integer]
    def latest_platform_archive_id(is_host, project_name, branch_name, env, platform)
      latest_archive_id(is_host, project_name, branch_name, env, lambda { |archive_id|
        Dir.exist?(platform_dir_path(is_host, project_name, branch_name, env, archive_id, platform))
      })
    end
  end
end

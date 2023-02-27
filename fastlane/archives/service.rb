module Archives
  class Service
    # @param [Boolean]
    # @param [String]
    # @param [String]
    # @param [Shipping]
    # @param [String]
    # @param [Integer]
    def self.copy_archive_to_next_archive(is_host, project_name, branch_name, env, platform)
      archive = Archives::Archive.new

      latest_archive_id = archive.latest_platform_archive_id(is_host, project_name, branch_name, env, platform)
      return unless latest_archive_id.positive?

      next_archive_id = latest_archive_id + 1
      next_archive_id_path = archive.archive_dir_path(is_host, project_name, branch_name, env, next_archive_id)
      FileUtils.mkdir_p(next_archive_id_path)

      latest_archive_dir_path = archive.platform_dir_path(is_host, project_name, branch_name, env, latest_archive_id, platform)
      next_archive_dir_path = archive.platform_dir_path(is_host, project_name, branch_name, env, next_archive_id, platform)

      `cp -r #{latest_archive_dir_path} #{next_archive_dir_path}`
    end
  end
end

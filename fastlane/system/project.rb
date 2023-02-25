module System
  class Project
    def self.repo_root_path
      ENV.fetch('REPOSITORY_ROOT_PATH', '')
    end
  end
end

module System
  class Project
    def self.root_path
      ENV.fetch('REPOSITORY_ROOT_PATH', '')
    end
  end
end

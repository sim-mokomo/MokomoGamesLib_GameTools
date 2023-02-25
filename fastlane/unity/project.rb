module Unity
  class Project
    attr_reader :repo_root_path

    # @param [String]
    def initialize(repo_root_path)
      @repo_root_path = repo_root_path
    end

    # @return [String]
    def root_path
      client_root_folder_name = 'client'.freeze
      File.join(@repo_root_path, client_root_folder_name)
    end

    # @return [String]
    def assets_path
      File.join(root_path, 'Assets')
    end
  end
end

module Unity
  class Project
    attr_reader :project_root_path

    # @param [String]
    def initialize(project_root_path)
      @project_root_path = project_root_path
    end

    # @return [String]
    def root_path
      File.join(@project_root_path, 'client')
    end

    # @return [String]
    def assets_path
      File.join(project_root_path, 'Assets')
    end
  end
end

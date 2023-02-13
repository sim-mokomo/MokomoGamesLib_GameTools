module Unity
  class Project
    module IEnv
      def repo_root_path
        raise 'Not Implemented'
      end
    end

    class Env
      include IEnv

      def repo_root_path
        ENV.fetch('REPOSITORY_ROOT_PATH', '')
      end
    end

    # @return [Env]
    attr_reader :env

    def initialize(env)
      @env = env
    end

    # @return [String]
    def root_path
      env_repo_root_path = @env.repo
      client_root_folder_name = 'client'.freeze
      if env_repo_root_path.empty?
        File.join(File.expand_path('../../../'), client_root_folder_name)
      else
        File.join(env_repo_root_path, client_root_folder_name)
      end
    end

    # @return [String]
    def assets_path
      File.join(root_path, 'Assets')
    end
  end
end

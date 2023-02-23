module GithubActions
  class Repository
    # @param [String] key
    # @param [String] json
    # @param [Proc] executor
    def write_json_to_github_env(key, value, executor)
      github_env = ENV.fetch('GITHUB_ENV', '')
      return if github_env.empty?

      cmd = "echo '#{key}=#{value}' >> #{github_env}"
      executor.call(cmd)
    end
  end
end

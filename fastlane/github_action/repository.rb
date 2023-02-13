module GithubActions
  class Repository
    # @param [String] key
    # @param [String] json
    # @param [Proc] executor
    def write_json_to_github_env(key, json, executor)
      github_env = ENV.fetch('GITHUB_ENV', '')
      return if github_env.empty?

      json = json.gsub(/"/) { '\\\\\\"' }
      cmd = "echo '#{key}=#{json}' >> #{github_env}"
      executor.call(cmd)
    end
  end
end

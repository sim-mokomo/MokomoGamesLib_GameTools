require 'octokit'
require_relative '../system/configs/config'

module Github
  class API
    private

    attr_reader :shell_executor

    public

    def initialize(shell_executor)
      @shell_executor = shell_executor
    end

    def create_pr(base, compare, title, body, commit_message)
      Dir.chdir('../../') do
        @shell_executor.call("git switch -C #{compare}")
        @shell_executor.call('git add .')
        @shell_executor.call("git commit -m \"#{commit_message}\"")
        @shell_executor.call("git push -f origin #{compare}")
      end

      config = System::Configs::Config.load_config
      client = Octokit::Client.new(access_token: config.github.access_token)
      client.create_pull_request(config.github.repository_name, base, compare, title, body)
    end
  end
end

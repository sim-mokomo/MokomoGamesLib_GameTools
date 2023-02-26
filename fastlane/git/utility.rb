module Git
  class Utility
    CURRENT_GIT_BRANCH_KEY = 'CURRENT_GIT_BRANCH'.freeze
    def self.current_git_branch_key
      CURRENT_GIT_BRANCH_KEY
    end

    # @return [String]
    def self.get_current_branch_name
      if ENV.fetch('IS_DOCKER', true)
        ENV.fetch(CURRENT_GIT_BRANCH_KEY, '')
      else
        `git branch | grep \\* | cut -d ' ' -f2`.chomp!
      end
    end
  end
end

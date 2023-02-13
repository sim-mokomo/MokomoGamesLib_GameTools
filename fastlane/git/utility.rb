module Git
  class Utility
    # @return [String]
    def self.get_current_branch_name
      if ENV['IS_DOCKER']
        return ENV['CURRENT_GIT_BRANCH']
      else
        `git branch | grep \\* | cut -d ' ' -f2`.chomp!
      end
    end
  end
end

module Git
  class Utility
    # @return [String]
    def self.get_current_branch_name
      `git branch | grep \\* | cut -d ' ' -f2`.chomp!
    end
  end
end

module Build
  module Common
    class Result
      # @return [Float]
      attr_accessor :elapsed_time
      # @return [Unity::Platform]
      attr_accessor :platform
      # @return [Boolean]
      attr_accessor :succeeded

      # @param [Float]
      # @param [Unity::Platform]
      # @param [Boolean]
      def initialize(elapsed_time, platform, succeeded)
        @elapsed_time = elapsed_time
        @platform = platform
        @succeeded = succeeded
      end
    end
  end
end

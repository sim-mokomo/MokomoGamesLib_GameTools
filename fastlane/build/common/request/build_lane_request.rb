module Build
  module Common
    class BuildLaneRequest
      # @return [Shipping]
      attr_reader :environment
      # @return [Boolean]
      attr_reader :enable_notify
      # @return [Boolean]
      attr_reader :upload_to_appcenter
      # @return [Integer]
      attr_reader :build_id

      def initialize(options)
        @environment = options[:environment] || System::Shipping::DEV
        @enable_notify = options[:enable_notify].nil? ? true : options[:enable_notify]
        @upload_to_appcenter = options[:upload_to_appcenter].nil? ? false : options[:upload_to_appcenter]
        @build_id = options[:build_id]
      end
    end
  end
end

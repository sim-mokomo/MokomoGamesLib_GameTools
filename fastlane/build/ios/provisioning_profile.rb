require_relative '../../system/shipping'

module Build
  module IOS
    class ProvisioningProfile
      # @return [String]
      attr_reader :dev
      # @return [String]
      attr_reader :staging
      # @return [String]
      attr_reader :production

      # @param [String] dev
      # @param [String] production
      def initialize(dev, staging, production)
        @dev = dev
        @staging = staging
        @production = production
      end

      # @param [Shipping] environment
      # @return [String] provisioning_profile_name
      def get(environment)
        case environment
        when System::Shipping::DEV
          @dev
        when System::Shipping::STAGING
          @staging
        when System::Shipping::PRODUCTION
          @production
        end
      end
    end
  end
end

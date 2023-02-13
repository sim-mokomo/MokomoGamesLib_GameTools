require_relative '../../system/shipping'

module Build
  module IOS
    class Xcode
      # @return [String]
      def get_scheme
        'Unity-iPhone'
      end

      # @param [System::Shipping]
      # @return [String]
      def get_export_method(env)
        env == System::Shipping::PRODUCTION ? 'app-store' : 'development'
      end

      # @param [System::Shipping]
      # @return [String]
      def get_configuration(env)
        env == System::Shipping::PRODUCTION ? 'Release' : 'Debug'
      end
    end
  end
end

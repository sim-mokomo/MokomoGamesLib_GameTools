require_relative '../result'

module Build
  module Common
    module Notify
      class Service
        def notify_all_platform(build_results, send_slack_message)
          return unless build_results.any?

          notify_model = Build::Common::Notify::Model.new
          build_message = build_results.inject('') { |result, x| result + "#{notify_model.create_build_complete_message(x)}\n" }

          send_slack_message.call(
            'ビルドレポート',
            build_results.all?(&:succeeded),
            {
              'ビルド結果' => build_message
            }
          )
        end
      end
    end
  end
end

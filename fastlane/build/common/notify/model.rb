require_relative '../../../slack/icon'
require_relative '../result'

module Build
  module Common
    module Notify
      class Model
        # @param [Build::Common::Result] build_result
        # @param [Proc] succeed_sender
        def notify_unity_build(build_result, succeed_sender)
          title = build_result.succeeded ? 'ビルド完了' : 'ビルド失敗'
          succeed_sender.call(title, build_result.succeeded, { 'ビルド結果' => create_build_complete_message(build_result) })
        end

        # @param [Unity::Common::Build::Result] build_result
        # @return [String]
        def create_build_complete_message(build_result)
          platform_icon = SlackIcon.get_platform_icon(build_result.platform)
          result_status_icon = SlackIcon.get_result_status_icon(build_result.succeeded)
          "#{platform_icon} : #{result_status_icon} : ビルド時間#{build_result.elapsed_time.round}\n"
        end
      end
    end
  end
end

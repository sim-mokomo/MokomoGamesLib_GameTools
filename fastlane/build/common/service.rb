require_relative 'config'
require_relative '../../github_action/repository'
require_relative '../../system/extensions/string'
require_relative '../../archives/service'
require_relative '../../system/command/command'
require_relative '../../system/command/option'
require_relative '../../system/command/custom_option'
require_relative '../../system/command/parser'
require_relative '../../system/shipping'
require_relative '../../unity/app'
require_relative '../../unity/project'
require 'active_support/all'
require 'json'

module Build
  module Common
    class Service
      def build(platform, command, shell_executor)
        github_repository = GithubActions::Repository.new
        github_repository.write_json_to_github_env(
          'UNITY_BUILD_RESULT_PLATFORM',
          platform,
          shell_executor
        )
        build_result = exec_unity_build(platform, command, shell_executor)

        github_repository.write_json_to_github_env(
          'UNITY_BUILD_RESULT_ELAPSED_TIME',
          build_result.elapsed_time,
          shell_executor
        )
        github_repository.write_json_to_github_env(
          'UNITY_BUILD_RESULT_SUCCEEDED',
          build_result.succeeded,
          shell_executor
        )

        build_result
      end

      # @param [Build::Common::Config] build_config
      # @param [String] current_branch
      # @note インクリメントビルド向けの処理、次回のビルド用に過去のビルドをコピーする
      def copy_build_archive_to_next(build_config, current_branch)
        Archives::Service.copy_archive_to_next_archive(
          false,
          build_config.project_name,
          current_branch,
          build_config.environment,
          build_config.platform,
          build_config.build_id
        )
      end

      private

      # @param [System::Command] command
      def exec_unity_build(platform, command, shell_executor)
        succeeded = false

        build_time = Benchmark.realtime do
          cmd = System::Command::Parser.new.parse([command])
          shell_executor.call(cmd)
          succeeded = true
        rescue StandardError => e
          p e.message
        end

        Build::Common::Result.new(build_time, platform, succeeded)
      end
    end
  end
end

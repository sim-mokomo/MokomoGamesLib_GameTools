module Slack
  class Config
    # @return [String]
    attr_reader :webhook_url
    # @return [String]
    attr_reader :notify_user_id
    # @return [String]
    attr_reader :notify_slack_channel

    def initialize(webhook_url, notify_user_id, notify_slack_channel)
      @webhook_url = webhook_url
      @notify_user_id = notify_user_id
      @notify_slack_channel = notify_slack_channel
    end

    def self.load_from_json(json)
      Config.new(
        json['webhook_url'],
        json['notify_user_id'],
        json['notify_slack_channel']
      )
    end
  end
end

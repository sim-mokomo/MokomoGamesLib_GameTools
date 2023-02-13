require 'net/http'
require 'json'
require 'active_support/all'

module PlayFab
  class KeyValue
    # rubocop:disable Naming/MethodName
    # @return [String]
    attr_accessor :Key
    # @return [String]
    attr_accessor :Value
    # rubocop:enable Naming/MethodName

    def initialize(key, value)
      # rubocop:disable all
      @Key = key
      @Value = value
      # rubocop:enable all
    end
  end

  class API
    # @param [Array<KeyValue>]
    # @param [String] secret_key
    # @param [String] project_id
    def self.set_title_data(send_values, secret_key, project_id)
      uri = URI.parse("https://#{project_id}.playfabapi.com/Admin/SetTitleDataAndOverrides")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      params = {
        'KeyValues' => send_values.as_json
      }
      headers = {
        'X-SecretKey' => secret_key,
        'Content-Type' => 'application/json'
      }
      p send_values.as_json
      response = http.post(uri.path, JSON.generate(params.as_json), headers)
      p response.code
      p response.body
    end
  end
end

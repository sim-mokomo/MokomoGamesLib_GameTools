require 'google/apis/sheets_v4'
require_relative '../system/configs/config'

module GoogleApi
  class Factory
    # @return [Google::Apis::SheetsV4::SheetsService]
    def self.create_api_service
      config = System::Configs::Config.load_config
      service = Google::Apis::SheetsV4::SheetsService.new
      service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: File.open("/secret/localize/#{config.spreadsheet.api_key_file_name}"),
        scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
      )
      service
    end
  end
end

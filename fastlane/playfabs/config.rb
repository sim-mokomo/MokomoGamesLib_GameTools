module PlayFabs
  module Studios
    class Config
      # @return [String]
      attr_reader :project_id
      # @return [String]
      attr_reader :secret_key

      def initialize(project_id, secret_key)
        @project_id = project_id
        @secret_key = secret_key
      end
    end
  end

  class Config
    private

    # @return [Studio]
    attr_reader :dev_studio
    # @return [Studio]
    attr_reader :staging_studio
    # @return [Studio]
    attr_reader :production_studio

    public

    def initialize(dev_studio, staging_studio, production_studio)
      @dev_studio = dev_studio
      @staging_studio = staging_studio
      @production_studio = production_studio
    end

    # @return [Studio]
    def get_studio(env)
      case env
      when System::Shipping::DEV
        @dev_studio
      when System::Shipping::STAGING
        @staging_studio
      when System::Shipping::PRODUCTION
        @production_studio
      else
        throw "Error: サポートされていない環境です env:#{env}"
      end
    end

    def self.load_from_json(json)
      Config.new(
        Studios::Config.new(
          json['dev']['project_id'],
          json['dev']['secret_key']
        ),
        Studios::Config.new(
          json['staging']['project_id'],
          json['staging']['secret_key']
        ),
        Studios::Config.new(
          json['production']['project_id'],
          json['production']['secret_key']
        )
      )
    end
  end
end

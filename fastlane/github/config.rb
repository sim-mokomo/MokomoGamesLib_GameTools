module Github
  class Config
    # @return [String]
    attr_reader :access_token
    # @return [String]
    attr_reader :owner_name
    # @return [String]
    attr_reader :project_name

    def initialize(access_token, owner_name, project_name)
      @access_token = access_token
      @owner_name = owner_name
      @project_name = project_name
    end

    def repository_name
      "#{@owner_name}/#{@project_name}"
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['access_token'],
        json['owner_name'],
        json['project_name']
      )
    end
  end
end

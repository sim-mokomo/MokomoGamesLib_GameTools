module Unity
  class Config
    # @return [String]
    attr_reader :version
    # @return [String]
    attr_reader :project_name
    # @return [String]
    attr_reader :product_name

    def initialize(version, project_name, product_name)
      @version = version
      @project_name = project_name
      @product_name = product_name
    end

    # @return [Config]
    def self.load_from_json(json)
      Config.new(
        json['version'],
        json['project_name'],
        json['product_name']
      )
    end
  end
end

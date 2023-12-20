class Models::IntegrationsFactory
  def self.from_type(type)
    case type
    when 'notion'
      NotionIntegration.new
    else
      raise "Not supported type"
    end
  end
end

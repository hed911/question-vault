class Integrations::Factory
  def self.from_type(type)
    Integrations::IntegrationList.classes.find { |c| c.to_s == "Integrations::Implementations::#{type.camelize}" }
  end
end

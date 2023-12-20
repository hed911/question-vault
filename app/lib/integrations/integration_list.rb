class Integrations::IntegrationList
  def self.classes
    prefix = 'Integrations::Implementations::'
    pattern = File.join('app', 'lib', 'integrations', 'implementations', '*.rb')
    Dir.glob(pattern)
      .map { |path| File.basename(path, '.*') }
      .map { |filename| Object.const_get("#{prefix}#{filename.camelize}") }
  end

  def self.class_names
    classes.map(&:name)
  end

  def self.field_names(type)
    klass = classes.find { |c| c.to_s == "Integrations::Implementations::#{type.camelize}" }
    klass&.fields || []
  end
end

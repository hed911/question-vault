class Integrations::AbstractIntegration
  def self.name
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def self.fields
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def fetch_groups
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def fetch_group_content
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

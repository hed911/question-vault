class IntegrationViewObject
  include Rails.application.routes.url_helpers

  def initialize(model: nil, external_integrations:)
    @model = model
    @external_integrations = external_integrations
  end

  def url
    integration_path(@model&.id || 0)
  end 

  def title
    model_present? ? 'Edit integration' : 'New integration'
  end

  def footer_text
    model_present? ? 'Save changes' : 'Create record'
  end

  def model_present?
    @model.present?
  end

  def method
    :put
  end

  def hash
    {
      title:,
      footer_text:,
      model_present: model_present?,
      model: @model,
      url:,
      method:,
      external_integrations: @external_integrations
    }
  end
end
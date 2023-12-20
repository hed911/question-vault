module IntegrationResourceable
  extend ActiveSupport::Concern
  
  def edit_url
    Rails
      .application
      .routes
      .url_helpers
      .integration_path(id)
  end
  
  def destroy_url
    Rails
      .application
      .routes
      .url_helpers
      .integration_path(id)
  end
end

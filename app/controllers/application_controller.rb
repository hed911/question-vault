class ApplicationController < ActionController::Base
  helper_method :resource_name, :resource, :devise_mapping
  before_action :authenticate_user!
  before_action :decide_layout

  rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, with: :custom_error_handling

  def custom_error_handling(exception)
    @errors << exception.message
    @error_string = @errors.join('\n')
    Rails.logger.error "[INVALID_RECORD] Exception #{exception.class}: #{exception.message}"
    render partial: 'common/error_handler'
  end

  def in_api_namespace?
    controller_path.split('/').first == "api"
  end

  def decide_layout
    return if current_user || in_api_namespace?

    render layout: 'without_login'
  end
end



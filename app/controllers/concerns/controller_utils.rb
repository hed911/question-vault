module ControllerUtils
  extend ActiveSupport::Concern
  
  private

  def parent_param_id_key
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def klass
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def parent_klass
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def params_list
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def find_record
    @record = permitted_params[:id] == '0' ? nil : klass.find(permitted_params[:id])
  end

  def find_parent_record
    @parent_record = parent_klass.find permitted_params[parent_param_id_key]
  end

  def init_errors
    @errors = []
  end

  def external_integrations
    Integrations::IntegrationList
      .class_names
      .map { |name| { id: name, text: name.capitalize } }
  end

  def permitted_params
    params.permit params_list
  end
end
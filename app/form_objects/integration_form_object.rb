class IntegrationFormObject
  include ActiveModel::Model
  attr_accessor :params, :nested_params, :integration, :integrable, :user

  def initialize(params:, nested_params:, user:, integration:)
    @params = params
    @nested_params = nested_params
    @integration = integration || Integration.new
    @integrable = @integration.integrable || Models::IntegrationsFactory.from_type(params[:type])
    @user = user

    set_values
  end

  def valid?
    @integration.valid? && @integrable.valid?
  end

  def errors
    @integration.errors.full_messages + @integrable.errors.full_messages
  end
  
	def save!
    @integrable.save!
    @integration.integrable = @integrable
		@integration.save!
    @integration
	end

  private 

  def set_values
    parsed_params = params.merge({ user_id: @user.id }).except(:id, :type)
    @integration.assign_attributes(parsed_params)
    @integrable.assign_attributes(nested_params)
    @integration.integrable = @integrable
  end
end

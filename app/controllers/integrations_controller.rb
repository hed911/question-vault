class IntegrationsController < ApplicationController
  include ControllerUtils
  include DataUtils

  before_action :find_record, only: %i[edit update show destroy]
  before_action :init_errors, only: %i[update destroy]

  helper FormComponents
 
  def index
    set_statuses
    set_sources(include_local: false)
  end

  def filter
    fields = %i[status integrable_type]

    if permitted_params.key?(:integrable_type)
      permitted_params[:integrable_type] = "#{permitted_params[:integrable_type].camelize}Integration" 
    end

    qb = QueryBuilder.new(klass)
    qb.set_pagination(page: permitted_params[:page].to_i, size: 10)
    qb.set_order(field: :created_at, type: :asc)
    qb.add_condition(key: :user_id, value: current_user.id)
    qb.add_negated_condition(key: :status, value: 'deleted')
    fields.each { |k| qb.add_condition_if_value_present(key: k, value: permitted_params[k])}

    result = qb.fetch_results
    @total_pages = result[:total_pages]
    @current_page = permitted_params[:page].to_i
    @records = result[:results]
    render layout: false
  end
  
  def edit
    @view_object = IntegrationViewObject.new(
      model: @record,
      external_integrations:
    )
    render layout: false
  end

  def update
    form_object = IntegrationFormObject.new(
      params: permitted_params,
      nested_params: permitted_nested_params,
      user: current_user,
      integration: @record
    )
    form_object.save!
    render partial: 'common/update'
  end

  def destroy
    @record.destroy!
    render partial: 'common/destroy'
  end

  def form
    render partial: "concrete_integrations/#{permitted_params[:type]}", locals: { model: nil }
  end

  private

  def klass
    Integration
  end

  def params_list
    [
      :id,
      :description,
      :status,
      :integrable_type,
      :type,
      :page
    ]
  end

  def permitted_nested_params
    fields = Integrations::IntegrationList.field_names(params[:type])
    params.require(:nested).permit(fields)
  end
end

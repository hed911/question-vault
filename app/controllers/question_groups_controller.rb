class QuestionGroupsController < ApplicationController
  include ControllerUtils

  before_action :find_record, only: %i[edit update show destroy]
  before_action :init_errors, only: %i[update destroy]

  helper FormComponents
 
  def index
    @statuses = [
      { id: 'any', text: 'Any' },
      { id: 'active', text: 'Active' },
      { id: 'archived', text: 'Archived' }
    ]

    @sources = [
      { id: 'any', text: 'Any' },
      { id: 'local', text: 'Local' },
      *external_integrations
    ]
  end

  def filter
    fields = %i[status source]

    qb = QueryBuilder.new(klass)
    qb.set_pagination(page: permitted_params[:page].to_i, size: 10)
    qb.set_order(field: :created_at, type: :asc)
    qb.add_negated_condition(key: :status, value: 'deleted')
    fields.each { |k| qb.add_condition_if_value_present(key: k, value: permitted_params[k])}
    qb.add_raw_condition(**SqlGenerator.like(key: :name, value: permitted_params[:name]))

    result = qb.fetch_results
    @total_pages = result[:total_pages]
    @current_page = permitted_params[:page].to_i
    @records = result[:results]
    render layout: false
  end
  
  def edit
    @view_object = QuestionGroupViewObject.new(
      model: @record
    )
    render layout: false
  end

  def update
    if @record.present?
      @record.assign_attributes permitted_params
    else
      @record = klass.new(permitted_params.merge(user: current_user).except(:id))
    end
    @record.save!
    render partial: 'common/update'
  end

  def destroy
    @record.destroy!
    render partial: 'common/destroy'
  end

  private

  def klass
    QuestionGroup
  end

  def params_list
    [
      :id,
      :name,
      :status,
      :source,
      :description,
      :page
    ]
  end
end

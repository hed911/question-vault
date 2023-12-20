class QuestionsController < ApplicationController
  include ControllerUtils
  include Rails.application.routes.url_helpers

  before_action :find_parent_record, only: %i[index filter edit update destroy]
  before_action :find_record, only: %i[edit update destroy]
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

    set_difficulty_levels

    gon.push({ parent_id: @parent_record.id })
  end

  def filter
    fields = %i[status source difficulty_level]

    qb = QueryBuilder.new(klass)
    qb.set_pagination(page: permitted_params[:page].to_i, size: 10)
    qb.set_order(field: :created_at, type: :asc)
    qb.add_condition(key: :question_group_id, value: @parent_record.id)
    qb.add_negated_condition(key: :status, value: 'deleted')
    fields.each { |k| qb.add_condition_if_value_present(key: k, value: permitted_params[k])}
    qb.add_raw_condition(**SqlGenerator.like(key: :query, value: permitted_params[:query]))

    result = qb.fetch_results
    @total_pages = result[:total_pages]
    @current_page = permitted_params[:page].to_i
    @records = result[:results]
    render layout: false
  end
  
  def edit
    set_difficulty_levels
    @difficulty_levels.shift

    @view_object = QuestionViewObject.new(
      model: @record,
      parent: @parent_record
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

  def set_difficulty_levels
    @difficulty_levels = [
      { id: 'any', text: 'Any' },
      { id: 'easy', text: 'Easy' },
      { id: 'medium', text: 'Medium' },
      { id: 'hard', text: 'Hard' }
    ]
  end

  def parent_klass
    QuestionGroup
  end

  def klass
    Question
  end

  def parent_param_id_key
    :question_group_id
  end

  def params_list
    [
      :question_group_id,
      :id,
      :query,
      :answer,
      :status,
      :source,
      :difficulty_level,
      :page
    ]
  end
end

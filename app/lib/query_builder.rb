class QueryBuilder
  attr_accessor :klass, :conditions, :raw_conditions, :order_options, :pagination_options

  def initialize(klass)
    @klass = klass
    @conditions = {}
    @negated_conditions = {}
    @raw_conditions = []
    @order_options = {}
    @pagination_options = {}
  end

  def add_condition_if_value_present(key:, value:)
    return unless value.present?
  
    @conditions[key] = value
  end

  def add_condition(key:, value:)
    @conditions[key] = value
  end

  def add_negated_condition(key:, value:)
    @negated_conditions[key] = value
  end

  def add_raw_condition(string)
    return unless string.present?

    @raw_conditions << string
  end

  def set_order(field:, type: :asc)
    options = {}
    options[field] = type
    @order_options = options
  end

  def set_pagination(page:, size: 10)
    @pagination_options = { page:, per_page: size }
  end

  def fetch_results
    records = @pagination_options.empty? ? execute_query : execute_query_with_paginate

    result = { results: records }
    result[:total_pages] = records.total_pages unless pagination_options.empty?
    result
  end

  private 

  def execute_query
    @klass
      .where(@conditions)
      .where.not(@negated_conditions)
      .where(raw_conditions_joined)
      .order(@order_options)
  end

  def execute_query_with_paginate
    @klass
      .where(@conditions)
      .where.not(@negated_conditions)
      .where(raw_conditions_joined)
      .order(@order_options)
      .paginate(@pagination_options)
  end

  def raw_conditions_joined
    @raw_conditions.join(' AND ')
  end
end

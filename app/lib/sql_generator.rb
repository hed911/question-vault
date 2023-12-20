class SqlGenerator

  def self.like(key:, value:)
    return unless value.present?

    "#{key} LIKE '%#{ActiveRecord::Base.sanitize_sql_like(value)}%'"
  end
end

class SqlGenerator
  def self.like(key:, value:)
    return { string: nil, value: nil } unless value.present?

    {
      string: "#{key} LIKE '%' || ? || '%'",
      value: ActiveRecord::Base.sanitize_sql_like(value)
    }
  end
end

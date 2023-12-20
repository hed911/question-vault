class Integration < ApplicationRecord
  include Statusable
  include Softdeleteable
  include IntegrationResourceable

  belongs_to :user
  belongs_to :integrable, polymorphic: true
  has_many :question_groups
  has_many :questions

  def type
    integrable_type&.sub('Integration', '')&.capitalize
  end
end
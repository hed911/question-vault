class QuestionGroup < ApplicationRecord
  include Statusable
  include Sourceable
  include Softdeleteable
  include QuestionGroupResourceable
  
  has_many :questions
  belongs_to :user
  belongs_to :integration, optional: true

  validates :name, presence: true
end

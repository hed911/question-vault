class Question < ApplicationRecord
  include Statusable
  include Sourceable
  include QuestionResourceable
  include Softdeleteable

  belongs_to :question_group
  belongs_to :user
  belongs_to :integration, optional: true

  enum :difficulty_level, %i[easy medium hard]
end

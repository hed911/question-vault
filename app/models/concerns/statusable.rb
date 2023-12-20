module Statusable
  extend ActiveSupport::Concern

  included do
    validates :status, presence: true
    enum :status, %i[active archived deleted]
    scope :only_available, -> { where(status: :active) }
  end
end

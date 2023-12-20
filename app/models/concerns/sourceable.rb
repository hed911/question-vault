module Sourceable
  extend ActiveSupport::Concern

  included do
    validates :source, presence: true
    enum :source, %i[local notion]
  end
end

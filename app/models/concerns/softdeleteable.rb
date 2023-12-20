module Softdeleteable
  extend ActiveSupport::Concern

  def destroy
    self.deleted!
  end
end

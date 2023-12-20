require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:questions) }
    it { should have_many(:question_groups) }
    it { should have_many(:integrations) }
  end
end

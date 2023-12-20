require 'rails_helper'

RSpec.describe Integration, type: :model do
  let(:user) { User.create(email: 'edward.elric@gmail.com', password: '12345678') }
  let(:integrable) { NotionIntegration.create(page_id: '1', secret_key: '2') }
  let(:integration) { Integration.new(description: 'Test', user_id: user.id, integrable:) }

  it 'should set status as active by default' do
    expect(integration.active?).to be_truthy
  end

  it 'should softdelete a record using destroy method' do
    integration.save!
    integration.destroy!
    expect(integration.deleted?).to be_truthy
  end

  describe 'url generation' do
    it 'should return the corresponding edit_url' do
      integration.save!
      expect(integration.edit_url).to eq "/integrations/#{integration.id}"
    end

    it 'should return the corresponding destroy_url' do
      integration.save!
      expect(integration.destroy_url).to eq "/integrations/#{integration.id}"
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
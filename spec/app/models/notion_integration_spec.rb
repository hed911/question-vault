require 'rails_helper'

RSpec.describe NotionIntegration, type: :model do
  let(:integrable) { NotionIntegration.new(page_id: '1', secret_key: '2') }

  it 'should not save when page_id is empty' do
    integrable.page_id = ''
    expect(integrable.valid?).to be_falsey
  end

  it 'should not save when page_id is NULL' do
    integrable.page_id = nil
    expect(integrable.valid?).to be_falsey
  end

  it 'should not save when secret_key is empty' do
    integrable.secret_key = ''
    expect(integrable.valid?).to be_falsey
  end

  it 'should not save when secret_key is NULL' do
    integrable.secret_key = nil
    expect(integrable.valid?).to be_falsey
  end

  it 'should return a notion client' do
    expect(integrable.client.class).to eq Integrations::Implementations::Notion
  end

  describe 'associations' do
    it { should have_one(:integration) }
  end
end
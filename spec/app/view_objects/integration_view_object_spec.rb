require 'rails_helper'

RSpec.describe IntegrationViewObject, type: :model do
  let(:external_integrations) { [{ id: '1', text: 'Notion' }] }
  let(:user) { User.create(email: 'edward.elric@gmail.com', password: '12345678') }
  let(:integrable) { NotionIntegration.create(page_id: '1', secret_key: '2') }
  let(:integration) { Integration.create(description: 'Test', user_id: user.id, integrable:) }
  
  describe 'model present' do
    let(:view_object) { IntegrationViewObject.new(model: integration, external_integrations:) }

    it 'should use the id of the model for the url' do
      expect(view_object.url).to eq "/integrations/#{integration.id}"
    end

    it 'should return a title corresponding to editing' do
      expect(view_object.title).to eq 'Edit integration'
    end

    it 'should return a footer corresponding to editing' do
      expect(view_object.footer_text).to eq 'Save changes'
    end

    it 'should return :put for method' do
      expect(view_object.method).to eq :put
    end

    it 'should return true for model_present?' do
      expect(view_object.model_present?).to be_truthy
    end

    it 'should return a hash of options' do
      hash = view_object.hash
      expect(hash[:title]).to eq 'Edit integration'
      expect(hash[:footer_text]).to eq 'Save changes'
      expect(hash[:model_present]).to be_truthy
      expect(hash[:model]).to eq integration
      expect(hash[:url]).to eq "/integrations/#{integration.id}"
      expect(hash[:method]).to eq :put
    end
  end
  
  describe 'model not present' do
    let(:view_object) { IntegrationViewObject.new(external_integrations:) }

    it 'should use "0" as id of the model for the url' do
      expect(view_object.url).to eq '/integrations/0'
    end

    it 'should return a title corresponding to creation' do
      expect(view_object.title).to eq 'New integration'
    end

    it 'should return a footer corresponding to editing' do
      expect(view_object.footer_text).to eq 'Create record'
    end

    it 'should return :put for method' do
      expect(view_object.method).to eq :put
    end

    it 'should return false for model_present?' do
      expect(view_object.model_present?).to be_falsey
    end

    it 'should return a hash of options' do
      hash = view_object.hash
      expect(hash[:title]).to eq 'New integration'
      expect(hash[:footer_text]).to eq 'Create record'
      expect(hash[:model_present]).to be_falsey
      expect(hash[:model]).to eq nil
      expect(hash[:url]).to eq '/integrations/0'
      expect(hash[:method]).to eq :put
    end
  end
end

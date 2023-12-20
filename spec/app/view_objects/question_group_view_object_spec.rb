require 'rails_helper'

RSpec.describe QuestionGroupViewObject, type: :model do
  let(:user) { User.create(email: 'edward.elric@gmail.com', password: '12345678') }
  let(:question_group) { QuestionGroup.create(name: 'Databases', user_id: user.id) }
  
  describe 'model present' do
    let(:view_object) { QuestionGroupViewObject.new(model: question_group) }

    it 'should use the id of the model for the url' do
      expect(view_object.url).to eq "/question_groups/#{question_group.id}"
    end

    it 'should return a title corresponding to editing' do
      expect(view_object.title).to eq 'Edit question group'
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
      expect(hash[:title]).to eq 'Edit question group'
      expect(hash[:footer_text]).to eq 'Save changes'
      expect(hash[:model_present]).to be_truthy
      expect(hash[:model]).to eq question_group
      expect(hash[:url]).to eq "/question_groups/#{question_group.id}"
      expect(hash[:method]).to eq :put
    end
  end
  
  describe 'model not present' do
    let(:view_object) { QuestionGroupViewObject.new }

    it 'should use "0" as id of the model for the url' do
      expect(view_object.url).to eq '/question_groups/0'
    end

    it 'should return a title corresponding to creation' do
      expect(view_object.title).to eq 'New question group'
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
      expect(hash[:title]).to eq 'New question group'
      expect(hash[:footer_text]).to eq 'Create record'
      expect(hash[:model_present]).to be_falsey
      expect(hash[:model]).to eq nil
      expect(hash[:url]).to eq '/question_groups/0'
      expect(hash[:method]).to eq :put
    end
  end
end

require 'rails_helper'

RSpec.describe QuestionGroup, type: :model do
  let(:user) { User.create(email: 'edward.elric@gmail.com', password: '12345678') }
  let(:question_group) { QuestionGroup.new(name: 'Databases', user_id: user.id) }

  it 'should not save when name is empty' do
    question_group.name = ''
    expect(question_group.valid?).to be_falsey
  end

  it 'should save successfully with NULL name' do
    question_group.name = nil
    expect(question_group.valid?).to be_falsey
  end

  it 'should set status as active by default' do
    expect(question_group.active?).to be_truthy
  end

  it 'should set source as local by default' do
    expect(question_group.local?).to be_truthy
  end

  it 'should softdelete a record using destroy method' do
    question_group.save
    question_group.destroy!
    expect(question_group.deleted?).to be_truthy
  end

  describe 'url generation' do
    it 'should return the corresponding questions_url' do
      question_group.save
      expect(question_group.questions_url).to eq "/question_groups/#{question_group.id}/questions"
    end

    it 'should return the corresponding edit_url' do
      question_group.save
      expect(question_group.edit_url).to eq "/question_groups/#{question_group.id}"
    end

    it 'should return the corresponding destroy_url' do
      question_group.save
      expect(question_group.destroy_url).to eq "/question_groups/#{question_group.id}"
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:questions) }
  end
end
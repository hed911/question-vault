require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) { User.create(email: 'edward.elric@gmail.com', password: '12345678') }
  let(:question_group) { QuestionGroup.new(name: 'Databases', user_id: user.id) }
  let(:question) { Question.new(query: 'What means A.C.I.D?', user_id: user.id, question_group_id: question_group.id) }

  it 'should not save when name is empty' do
    question.query = ''
    expect(question.valid?).to be_falsey
  end

  it 'should save successfully with NULL name' do
    question.query = nil
    expect(question.valid?).to be_falsey
  end

  it 'should set status as active by default' do
    expect(question_group.active?).to be_truthy
  end

  it 'should set source as local by default' do
    expect(question_group.local?).to be_truthy
  end

  it 'should softdelete a record using destroy method' do
    question_group.save!
    question.save!
    question.destroy!
    expect(question.deleted?).to be_truthy
  end

  describe 'url generation' do
    it 'should return the corresponding edit_url' do
      question_group.save!
      question.save!
      expect(question.edit_url).to eq "/question_groups/#{question_group.id}/questions/#{question.id}"
    end

    it 'should return the corresponding destroy_url' do
      question_group.save!
      question.save!
      expect(question.destroy_url).to eq "/question_groups/#{question_group.id}/questions/#{question.id}"
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:question_group) }
  end
end
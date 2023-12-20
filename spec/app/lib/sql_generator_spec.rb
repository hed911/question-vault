require 'rails_helper'

RSpec.describe SqlGenerator, type: :model do
  describe 'like' do
    it 'should generate a basic like condition' do
      expected_query = "name LIKE '%edward%'"
      expect(SqlGenerator.like(key: 'name', value: 'edward')).to eq expected_query
    end

    it 'should return NULL with empty value' do
      expect(SqlGenerator.like(key: 'name', value: '')).to eq nil
    end

    it 'should sanitize the value against SQL injection attacks' do
      expected_query = "name LIKE '%edward\\%'%'"
      expect(SqlGenerator.like(key: 'name', value: "edward%'")).to eq expected_query
    end
  end
end

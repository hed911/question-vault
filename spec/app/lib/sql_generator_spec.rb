require 'rails_helper'

RSpec.describe SqlGenerator, type: :model do
  describe 'like' do
    it 'should generate a basic like condition' do
      expected_result = {
        string: "name LIKE '%' || ? || '%'",
        value: 'edward'
      }
      expect(SqlGenerator.like(key: 'name', value: 'edward')).to eq expected_result
    end

    it 'should return NULL with empty value' do
      expected_result = {
        string: nil,
        value: nil
      }
      expect(SqlGenerator.like(key: 'name', value: '')).to eq expected_result
    end

    it 'should sanitize the value by removing bad characters' do
      expected_result = {
        string: "name LIKE '%' || ? || '%'",
        value: 'edward\\%'
      }
      expect(SqlGenerator.like(key: 'name', value: 'edward%')).to eq expected_result
    end
  end
end

require 'rails_helper'

RSpec.describe Parsers::NotionParser, type: :model do
  describe 'decorate groups' do
    it 'should return an empty array when results is empty' do
      parser = Parsers::NotionParser.new
      expect(parser.decorate_groups([])).to eq []
    end

    it 'should return a parsed version of data' do
      parser = Parsers::NotionParser.new
      input = [
        OpenStruct.new(id: 1, child_page: { title: 'Test 1' }),
        OpenStruct.new(id: 2, child_page: { title: 'Test 2' })
      ]
      output = [
        { id: 1, text: 'Test 1' },
        { id: 2, text: 'Test 2' }
      ]
      expect(parser.decorate_groups(input)).to eq output
    end
  end

  describe 'decorate group content' do
    it 'should return an empty array when results is empty' do
      parser = Parsers::NotionParser.new
      expect(parser.decorate_group_content([])).to eq []
    end

    it 'should return a parsed version of data' do
      parser = Parsers::NotionParser.new
      input = [
        OpenStruct.new(id: 1, bulleted_list_item: { rich_text: [{ text: { content: 'Question 1' } }] }),
        OpenStruct.new(id: 2, bulleted_list_item: { rich_text: [{ text: { content: 'Question 2' } }] })
      ]
      output = [
        { id: 1, text: 'Question 1' },
        { id: 2, text: 'Question 2' }
      ]
      expect(parser.decorate_group_content(input)).to eq output
    end
  end
end

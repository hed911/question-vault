require 'rails_helper'

RSpec.describe Integrations::Implementations::Notion, type: :model do
  let(:implementation) { Integrations::Implementations::Notion.new(page_id: "1", secret_key: "2") }
  let(:notion_block_children_methods) { instance_double(Notion::Api::BlocksChildrenMethods) }

  it 'should return corresponding name to class' do
    expect(Integrations::Implementations::Notion.name).to eq 'notion'
  end

  it 'should return corresponding fields to class' do
    expect(Integrations::Implementations::Notion.fields).to eq %i[page_id secret_key]
  end

  describe 'main' do
    before :each do
      allow(Notion::Api::BlocksChildrenMethods)
      .to receive(:new)
      .and_return(notion_block_children_methods)

      allow(notion_block_children_methods)
        .to receive(:list)
        .and_return(OpenStruct.new(data: []))
    end

    it 'should fetch groups from notion api' do
      expect(implementation.fetch_groups).to eq []
    end

    it 'should fetch group content from notion api' do
      expect(implementation.fetch_group_content('1029303b-12312ad-d12312')).to eq []
    end
  end
end

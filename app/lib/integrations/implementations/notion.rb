class Integrations::Implementations::Notion < Integrations::AbstractIntegration
  attr_accessor :page_id, :secret_key, :parser

  def initialize(page_id:, secret_key:, parser: Parsers::NotionParser.new)
    @page_id = page_id
    @secret_key = secret_key
    @parser = parser
  end

  def client
    @client ||= Notion::Client.new(token: secret_key)
  end

  def self.name
    'notion'
  end

  def self.fields
    %i[page_id secret_key]
  end

  def fetch_groups
    results = client.blocks.children.list page_id
    parser.decorate_groups(results.data)
  end

  def fetch_group_content(group_id)
    results = client.blocks.children.list group_id
    parser.decorate_group_content(results.data)
  end
end

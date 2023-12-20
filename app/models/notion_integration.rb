class NotionIntegration < ApplicationRecord
  has_one :integration, as: :integrable

  validates :page_id, presence: true
  validates :secret_key, presence: true

  def source_name
    'notion'
  end

  def client
    @client ||= Integrations::Implementations::Notion.new(page_id:, secret_key:)
  end
end

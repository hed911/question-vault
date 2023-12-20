class CreateNotionIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :notion_integrations do |t|
      t.text                  :page_id
      t.text                  :secret_key
      t.timestamps
    end
  end
end

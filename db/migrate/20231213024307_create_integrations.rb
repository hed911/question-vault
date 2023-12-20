class CreateIntegrations < ActiveRecord::Migration[7.0]
  def change
    create_table :integrations do |t|
      t.text                  :description
      t.integer               :status, default: 0
      t.references            :integrable, polymorphic: true
      t.timestamps
    end

    add_reference :integrations, :user, foreign_key: true, index: true
  end
end

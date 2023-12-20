class CreateQuestionGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :question_groups do |t|
      t.integer               :source, default: 0
      t.string                :source_id
      t.string                :name
      t.integer               :status, default: 0
      t.text                  :description
      t.timestamps
    end
    add_reference :question_groups, :user, foreign_key: true, index: true

    add_index :question_groups, :source_id, unique: true
  end
end

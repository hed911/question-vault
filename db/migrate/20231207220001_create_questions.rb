class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer               :source, default: 0
      t.string                :source_id
      t.string                :query
      t.text                  :answer
      t.integer               :status, default: 0
      t.integer               :difficulty_level
      t.timestamps
    end
    add_reference :questions, :question_group, foreign_key: true, index: true
    add_reference :questions, :user, foreign_key: true, index: true
    
    add_index :questions, %i[user_id difficulty_level]
    add_index :questions, %i[user_id status]
    add_index :questions, %i[user_id source]
    add_index :questions, :source_id, unique: true
  end
end
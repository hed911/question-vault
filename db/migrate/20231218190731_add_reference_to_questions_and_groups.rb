class AddReferenceToQuestionsAndGroups < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_groups, :integration, foreign_key: true, index: true
    add_reference :questions, :integration, foreign_key: true, index: true
  end
end

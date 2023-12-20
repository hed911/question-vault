module QuestionResourceable
  extend ActiveSupport::Concern
  
  def edit_url
    Rails
      .application
      .routes
      .url_helpers
      .question_group_question_path(id:, question_group_id:)
  end
  
  def destroy_url
    Rails
      .application
      .routes
      .url_helpers
      .question_group_question_path(id:, question_group_id:)
  end
end

module QuestionGroupResourceable
  extend ActiveSupport::Concern

  def questions_url
    Rails
      .application
      .routes
      .url_helpers
      .question_group_questions_path(question_group_id: id)
  end
  
  def edit_url
    Rails
      .application
      .routes
      .url_helpers
      .question_group_path(id)
  end
  
  def destroy_url
    Rails
      .application
      .routes
      .url_helpers
      .question_group_path(id)
  end
end

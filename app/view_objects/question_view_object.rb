class QuestionViewObject
  include Rails.application.routes.url_helpers

  def initialize(parent:, model: nil)
    @model = model
    @parent = parent
  end

  def url
    question_group_question_path(id: @model&.id || 0, question_group_id: @parent.id)
  end 

  def title
    model_present? ? "Edit question" : "New question"
  end

  def footer_text
    model_present? ? "Save changes" : "Create record"
  end

  def model_present?
    @model.present?
  end

  def method
    :put
  end

  def hash
    {
      title:,
      footer_text:,
      model_present: model_present?,
      model: @model,
      url:,
      method:
    }
  end
end
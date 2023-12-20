class QuestionGroupViewObject
  include Rails.application.routes.url_helpers

  def initialize(model: nil)
    @model = model
  end

  def url
    question_group_path(@model&.id || 0)
  end 

  def title
    model_present? ? "Edit question group" : "New question group"
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
      title: title,
      footer_text: footer_text,
      model_present: model_present?,
      model: @model,
      url: url,
      method: method
    }
  end
end
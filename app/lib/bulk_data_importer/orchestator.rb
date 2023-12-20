class BulkDataImporter::Orchestator
  include BulkDataImporter::GroupsFetcher
  include BulkDataImporter::QuestionsFetcher

  attr_accessor :groups, :questions

  def initialize(integration)
    @integration = integration
    @groups = []
    @questions = []
  end

  def start
    fetch_groups
    save_groups!
    fetch_questions
    save_questions!
  end

  def output
    {
      questions_count: @integration.questions.count,
      question_groups_count: @integration.question_groups.count
    }
  end

  def save_groups!
    QuestionGroup.import(@groups)
    @groups = @integration.question_groups
  end

  def save_questions!
    Question.import(@questions)
  end
end
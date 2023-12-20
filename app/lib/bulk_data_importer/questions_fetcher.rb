module BulkDataImporter::QuestionsFetcher
  def fetch_questions_by_group(group)
    integrable = @integration.integrable
    integrable.client.fetch_group_content(group.source_id).each do |external_question|
      question = group.questions.find_by({
        user: @integration.user,
        source_id: external_question[:id],
        source: integrable.source_name
      })
  
      if question.present?
        if question.query != question[:text]
          question.update_attribute(:query, question[:text])
        end
        next
      end
  
      @questions << Question.new({
        query: external_question[:text],
        source_id: external_question[:id],
        user: @integration.user,
        question_group: group,
        source: integrable.source_name,
        integration: @integration
      })
    end
  end

  def fetch_questions
    @questions = []
    @groups.each { |group| fetch_questions_by_group(group) }
  end
end
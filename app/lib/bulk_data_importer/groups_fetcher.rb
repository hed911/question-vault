module BulkDataImporter::GroupsFetcher
  def fetch_groups
    @groups = []
    integrable = @integration.integrable
    integrable.client.fetch_groups.each do |external_group|
      question_group = QuestionGroup.find_by({
        user: @integration.user,
        source_id: external_group[:id],
        source: integrable.source_name
      })
  
      if question_group.present?
        if question_group.name != external_group[:text]
          question_group.update_attribute(:name, external_group[:text])
        end
        next
      end
  
      @groups << QuestionGroup.new({
        name: external_group[:text],
        source_id: external_group[:id],
        user: @integration.user,
        description: 'Automigrated',
        source: integrable.source_name,
        integration: @integration
      })
    end
  end
end
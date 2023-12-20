class Parsers::NotionParser
  def decorate_groups(results)
    results.map { |r| { id: r.id, text: r.child_page.with_indifferent_access[:title] } }
  end

  def decorate_group_content(results)
    filtered_results = results.select { |r| r.bulleted_list_item.present? }
    filtered_results.map do |record|
      id = record.id
      text = record
        .bulleted_list_item
        .with_indifferent_access['rich_text'][0]
        .with_indifferent_access['text']
        .with_indifferent_access['content']
      { id:, text: }
    end
  end
end

module FormComponents
  def radio_button_list(list: [], title:, checked_id: nil, field_name:)
    content_tag :div, class: 'row' do
      content_tag(:p, title, class: 'form-radio-label') + 
      list.reduce(ActiveSupport::SafeBuffer.new("")) do |acum, item|
        acum + content_tag(:div, class: 'form-check') do
          opts = { 
            class: 'form-check-input bind-search',
            type: 'radio',
            name: field_name,
            id: "#{field_name}_#{item[:id]}",
            value: item[:id]
          }
          opts[:value] = "" if item[:id] == "any"
          opts[:checked] = '' if checked_id == item[:id]

          content_tag(:input, nil, opts) +
          content_tag(:label, item[:text], class: 'form-check-label', for: "#{field_name}_#{item[:id]}")
        end
      end
    end
  end
end

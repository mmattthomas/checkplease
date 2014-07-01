json.array!(@checklist_items) do |checklist_item|
  json.extract! checklist_item, :id, :check_name, :check_description
  json.url checklist_item_url(checklist_item, format: :json)
end

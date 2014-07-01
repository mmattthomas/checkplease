json.array!(@checklists) do |checklist|
  json.extract! checklist, :id, :name, :description, :expires_on
  json.url checklist_url(checklist, format: :json)
end

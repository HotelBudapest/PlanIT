json.extract! poll, :id, :event_id, :title, :created_at, :updated_at
json.url poll_url(poll, format: :json)

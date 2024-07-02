json.extract! vote, :id, :poll_id, :user_id, :status, :created_at, :updated_at
json.url vote_url(vote, format: :json)

json.extract! user, :id, :email, :password, :conf_password, :name, :created_at, :updated_at
json.url user_url(user, format: :json)

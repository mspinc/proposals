json.extract! location, :id, :name, :code, :city, :country, :created_at, :updated_at
json.url location_url(location, format: :json)

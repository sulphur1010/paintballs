json.extract! game, :id, :title, :image, :description, :slug, :created_at, :updated_at
json.url game_url(game, format: :json)
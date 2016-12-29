class Game < ActiveRecord::Base
	has_attached_file :image, styles: { medium: "400x600#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	belongs_to :members
	has_many :reviews
	#include FriendlyId
	searchkick
	extend FriendlyId
    friendly_id :name, use: :slugged
end

class Review < ActiveRecord::Base
	belongs_to :games
	belongs_to :members
end

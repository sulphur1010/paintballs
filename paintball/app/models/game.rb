class Game < ActiveRecord::Base
	belongs_to :members
	#include FriendlyId
end

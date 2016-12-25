class Jointmemberteam < ActiveRecord::Base
  belongs_to :member
  belongs_to :team
end

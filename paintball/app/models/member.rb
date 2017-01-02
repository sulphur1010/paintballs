class Member < ActiveRecord::Base

  has_many :games
  has_many :joint_member_teams
  has_many :reviews, dependent: :destroy
  has_many :teams, :through => :joint_member_teams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    # Try building a slug based on the following fields in
  	# increasing order of specificity.

end

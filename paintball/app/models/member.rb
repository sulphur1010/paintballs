class Member < ActiveRecord::Base

	has_many :games
	has_many :members, :through => :joint_member_teams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


    friendly_id :name, :use => :slugged 

    def should_generate_new_friendly_id?
    	 slug.nil? || name_changed? || new_record?
 	end

    # Try building a slug based on the following fields in
  	# increasing order of specificity.
    def slug_candidates
    [
       :name,
      [:name, :alias]
    ]
   end

end

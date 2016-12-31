class Team < ActiveRecord::Base

 has_many :joint_member_teams 
 has_many :members, :through => :joint_member_teams
 mount_uploader  :logo, LogoUploader
 mount_uploader  :banner, BannerUploader


    extend FriendlyId
    friendly_id :name, use: :slugged
end


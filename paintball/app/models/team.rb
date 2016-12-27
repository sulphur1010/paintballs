class Team < ActiveRecord::Base

 has_many :members, :through => :joint_member_teams
 mount_uploader  :logo, LogoUploader
 mount_uploader  :banner, BannerUploader
end

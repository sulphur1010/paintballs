class TeamsController < ApplicationController
  layout 'dashboard'
	before_action :authenticate_member!
	before_action :set_up_member
	before_action :set_up_team, :except => [:new, :create ]




   def new
    render  :layout => 'wizard'
   end

   def index
   end

   def add_member
   	member_list = JSON.parse(params[:member_list])
   	email = member_list["email"]
   	status = member_list["status"]
   	new_member = Member.invite!({:email => email}, current_member)
   	result = JointMemberTeam.find_by(member_id:new_member.id, team_id:@team.id)
   	if result.nil?
   		#send notification
	    self.send_notification(new_member.id, 2 , params[:member_id], team.name)

   	#insert new member
   	one_member = JointMemberTeam.new(member_id:new_member.id, status:status, team_id:team.id)
   	one_member.save
   end
  end

  def invite_member
    mail_list = params[:mail_list]
    list = mail_list.split(",")
    list.map do |item|
    Invitemailer.member_invite_to_team(@team, item).deliver
  end
  redirect_to team_path(team_id:@team.id)
 end


  def remove_member
	  	member_team = JointMemberTeam.find(params[:member_team_id])
	  	if !member_team.destroy
	  		render plain: "failure"
	  	else
	  		#send notification
	  		self.send_notification(member_team.member.id, 4 , @member.id, @team.name)
	  		render plain: "success"

	  end
 end


  #make another person the creator
  def transfer_ownership
  	current_owner = JointMemberTeam.find(params[:current_owner])
  	new_owner = JointMemberTeam.find(params[:new_owner])
  	if current_owner.update_attributes(status:1) && new_owner.update_attributes(status:0)
  		#send notifications to members on their new status
  		self.send_notification(new_owner.member.id, 5, current_owner.member.id, @team.name)
  		redirect_to edit_team_path(@team)
     end
  end

  def create
	  	team = Team.new(create_team_params)
	  	if team.save
	  		#add the member as the super admin/creator of the team
	  		creator = JointMemberTeam.new(status:0, member_id:params[:member_id], team_id: team.id)
	  		creator.save
	  		#after this, loop through everyother member and send email to them
	  		collaborator_list = JSON.parse(params[:collaborator_list])
	  		collaborator_list.each do |coll|
	  		    email = coll["email"]
	  			status = coll["status"]

	  			#invite  new member with device
	  			member = Member.invite!({:email => email}, current_member)
	  			#check if coming member exists in the team
	  			result = JointMemberTeam.find_by(member_id: member.id, team_id: team.id)
	  			if result.nil?
	  				#send notification
	  				self.send_notification(member.id, 2 , params[:member_id], team.name)
	  				#add the new member to the jointmemberteam table
	  				newmember = JointMemberTeam.new(status:status, member_id:member.id, team_id:team.id)
	  				newmember.save
	  			end
	  		end
	  		redirect_to  member_dashboard_path
	  	else
	  	end

  end

  def show
  	    @member_status = JointMemberTeam.find_by(member_id: @member.id, team_id: @team.id)
        @sigin_in_count = current_member.sign_in_count.to_s
        @all_members = @team.members
        # @interviews = @company.interviews.includes(:users).where(submissions: {status: nil}).paginate(:page => params[:page], :per_page => 5) 
  end

  def all_members
  	@all_members = @team.members
  end

  def edit
  	@member_team = JointMemberTeam.find_by(member_id:@member.id, team_id:@team.id)
    #not too clear
  	@member =@team.joint_member_teams
  	@member_status = @member_team.status
  end

  

  def update
  	@team.update_attributes(create_team_params)
  	redirect_to edit_team_path
  end



  private
  def create_team_params
    params.permit(:name, :location, :level, :intro, :equipment, :logo, :banner)
  end


  def set_up_member
  	@member = current_member
  end

  def set_up_team
  	#find if the team exists
  	@team = Team.friendly.find(params[:team_id] || params[:id])
  	#find if the member belongs to that team
  	result = JointMemberTeam.find_by(member_id:@member.id, team_id:@team.id)
  	if result.nil?
  		redirect_to member_dashboard_path
  	end

  end


end

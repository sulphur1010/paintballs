class LandingsController < ApplicationController
  layout 'landing'
  def index
  	if member_signed_in?
			# redirect_to member_dashboard_path(current_member)
			  redirect_to  new_team_path
	end
  end
end

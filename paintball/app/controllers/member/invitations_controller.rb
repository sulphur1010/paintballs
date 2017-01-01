
class Members::InvitationsController < Devise::InvitationsController
  layout 'signin'
   skip_filter :require_no_authentication, :only => :edit
   before_action :devise_configure_permitted_parameters, if: :devise_controller?

  protected




  def devise_configure_permitted_parameters
  	if member_signed_in?
      sign_out current_member
    end

    devise_parameter_sanitizer.for(:accept_invitation) << :name
  end
  

end
class Members::RegistrationsController < Devise::RegistrationsController
layout 'signin'
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end
  

  # GET /resource/edit
  def edit
    @member = current_member
    # @notification = Notification.where(member_id: @member.id, read: 0)
    # render :layout => 'member_dashboard'
    # super

  end

  # PUT /resource
  def update
    @member = current_member
    # @notification = Notification.where(member_id: @member.id, read: 0)
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the member wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  #   if Rails.env.production?
  #     notifier = Slack::Notifier.new "https://hooks.slack.com/services/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", channel: '#development', membername: 'signup'
  #     notifier.ping "New Signup by " + params[:member][:name] + " email: " + params[:member][:email]
  #   end 
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # member_dashboard_path
    redirect_to  new_team_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end

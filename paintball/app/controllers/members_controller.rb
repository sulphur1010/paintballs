require 'bcrypt'
class membersController < ApplicationController
	layout 'member_dashboard'
	before_action :authenticate_member!
	
	# this is used to initial member's object to that it will be available to all 
	# method without recalling it again
	before_filter :set_up_member

    def set_up_member
        @member = current_member
        @notification = Notification.where(member_id: @member.id, read: 0)
    end


   def update_notification
	     @notification = Notification.find(params[:notification_id])
	    if !@notification.update_attributes(update_notification_params)
	       render plain: "failure"
	    else
	      render plain: "success"
	    end
   end


  def dashboard
		
  end

  def account
  	if params[:update].present?
	  	bcrypt_object = BCrypt::Password.new(@member.encrypted_password) 
	    password_hash = ::BCrypt::Engine.hash_secret(params[:current_password], bcrypt_object.salt)
        if password_hash == @member.encrypted_password
          if !params[:password].blank? 
            if (params[:password] == params[:confirm_password])
              @member.update_attributes(email: params[:email], name: params[:name], password: params[:password])
              flash.now[:success] = "Account Updated Successfully"
            else 
              flash.now[:danger] = "Password Didn't match"
            end
          else 
            @member.update_attributes(email: params[:email], name: params[:name])
             flash.now[:success] = "Account Updated Successfully"
          end
        else
          flash.now[:danger] = "Current password not correct"
        end 
     end
  end

  def check_password
  	 bcrypt_object = BCrypt::Password.new(@member.encrypted_password) 
     password_hash = ::BCrypt::Engine.hash_secret(params[:current_password], bcrypt_object.salt)
	    if password_hash == @member.encrypted_password
	    	render plain: "correct"
	    else
	    	render plain: "wrong"
	    end   
  end


    # parameters used to update the notification
  def update_notification_params
    params.permit(:read)
  end




end

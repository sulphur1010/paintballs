class MembersController < ApplicationController
  

  before_filter :set_up_member

   def set_up_member
        @member = current_member
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
end

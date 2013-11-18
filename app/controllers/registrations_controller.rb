class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(user_params)
    else
      # remove the virtual current_password attribute, update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(user_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to @user
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :remember_me, :password_hash, :password_salt,
                                 :username, :role, :avatar, :login, :role_ids,
                                 :time_zone, :likes, :hates, :style, :favorite_food)
  end

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      !params[:user][:password].blank?
  end
end

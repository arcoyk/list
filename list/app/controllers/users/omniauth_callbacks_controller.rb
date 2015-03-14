class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_or_create_by(user_params)
    if @user.persisted?
      session["user_name"] = request.env["omniauth.auth"]["info"]
      session["devise.twitter_data.name"] = request.env["omniauth.auth"]
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private
  def user_params
    puts request.inspect
    request.env["omniauth.auth"].slice(:provider, :uid).to_h
  end
end
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def twitter
    @user = User.find_for_twitter_oauth(env['omniauth.auth'])
    if params["email"] == nil && @user.email =="fake@fake.com"
      render "devise/registrations/write_mail"
    else
      unless params["email"] == nil
        @user.email = params["email"] 
        @user.save
      end
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
      else
        redirect_to new_user_registration_url
      end
    end
  end
end
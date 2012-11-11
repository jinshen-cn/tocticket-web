class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :get_auth
  def facebook
    @user = User.find_for_oauth(@auth, @auth.extra.raw_info.name, @auth.info.email)

    redirect_to_success_or_registration_again
  end
  def twitter
    @user = User.find_for_oauth(@auth, @auth.info.name, "fake@fake.com")
    # Ask for mail if is a new user
    if params["email"] == nil && @user.email =="fake@fake.com"
      render "devise/registrations/write_mail"
    else
      unless params["email"] == nil
        @user.email = params["email"] 
        @user.save
      end
      redirect_to_success_or_registration_again
    end
  end
  private
  def get_auth
    @auth = request.env["omniauth.auth"]
  end
  def redirect_to_success_or_registration_again
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => @auth.provider.capitalize) if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end
end
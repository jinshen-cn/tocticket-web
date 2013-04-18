class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => t('devise.message.no_authorize')
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => t('devise.message.no_authorize')
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => t('devise.message.user_update')
    else
      redirect_to users_path, :alert => t('devise.message.cant_update')
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => t('devise.message.no_authorize')
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => t('devise.message.user_delete')
    else
      redirect_to users_path, :notice => t('devise.message.cant_delete')
    end
  end
end
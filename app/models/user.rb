class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # Omniauth
  attr_accessible :provider, :uid
  def self.find_for_oauth(auth, name, email)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider:auth.provider,
                           uid:auth.uid,
                           name: name,
                           email: email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  # Relations with model
  has_many :events
  has_many :tickets
   
  before_create :set_default_role
  private
  def set_default_role
    if self.roles.empty?
      self.roles = [Role.find_by_name(:organizer)]
    end
  end
  
end

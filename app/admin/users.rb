ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :role do |user|
      user.roles.first.name.titleize
    end
    column "Last login date", :last_sign_in_at
    column "Login provider", :provider, :sortable => :provider do |user|
      user.provider.nil? ? "Email": user.provider.capitalize
    end
    default_actions
  end
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :roles, :as => :select
    end
    f.buttons
  end
end

ActiveAdmin.register Event do
  index do
    selectable_column
    column :id
    column :name
    column "Celebration date", :celebrated_at
    column :url
    column :price, :sortable => :price do |event|
      number_to_currency event.price
    end
    column :door_payment
    column :capacity
    column :selling_deadline
    default_actions
  end
  form do |f|
    f.inputs "Details" do
      f.input :organizer, :collection => Role.where('name = ?', :organizer).first.users
      f.input :name
      f.input :celebrated_at
      f.input :address
      f.input :price
      f.input :info
      f.input :url
      f.input :selling_deadline
      f.input :capacity
    end
    f.buttons
  end
end

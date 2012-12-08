ActiveAdmin.register Ticket do
  index do
    selectable_column
    column :id
    column :user do |ticket|
      ticket.user.name
    end
    column :event do |ticket|
      ticket.event.name
    end
    column "Number of attendees", :attendees
    column :paid
    default_actions
  end
  form do |f|
    f.inputs "Details" do
      f.input :event
      f.input :user, :collection => Role.where('name = ?', :attendee).first.users
      f.input :random_key
      f.input :attendees
      f.input :paid
    end
    f.buttons
  end

end

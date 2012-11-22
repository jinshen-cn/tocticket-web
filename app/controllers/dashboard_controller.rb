class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.has_role? :attendee
      redirect_to my_tickets_path
    elsif current_user.has_role? :organizer
      redirect_to events_path
    end
  end
end
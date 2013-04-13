class Api::V1::EventsController < ApplicationController
  before_filter :authenticate_user!

  # GET /events.json
  def index
    @events = Event.where("organizer_id=?",current_user.id)
    render json: @events
  end
end
class Api::V1::EventsController < ApplicationController
  before_filter :authenticate_user!

  # GET /events.json
  def index
    render json: current_user.events
  end
end
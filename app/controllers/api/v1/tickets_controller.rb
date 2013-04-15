class Api::V1::TicketsController < ApplicationController
  before_filter :authenticate_user!

  # POST /check_ticket
  def check
    @ticket = Ticket.find_by_event_id_and_id_and_random_key(params[:event], params[:ticket], params[:key])

    if @ticket.nil?
      render :status=>404, :json=>{:message=>"Ticket not found."}
    elsif @ticket.checked?
      render :status=>409, :json=>{:message=>"Ticket checked on #{l @ticket.updated_at, :format => :long}."}
    elsif !@ticket.paid?
      render :status=>409, :json=>{:message=>"Ticket NOT paid."}
    else
      @ticket.checked = true
      @ticket.save
      render json: @ticket
    end
  end

end
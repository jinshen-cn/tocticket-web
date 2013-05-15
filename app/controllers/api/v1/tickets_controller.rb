class Api::V1::TicketsController < ApplicationController
  before_filter :authenticate_user!

  # POST /check_ticket
  def check
    @event = Event.find(params[:event])
    @ticket = @event.tickets.find_by_id_and_random_key(params[:ticket], params[:key])

    if @ticket.nil?
      render :status=>404, :json=>{:message=>t('api.v1.ticket.not_found')}
    elsif @ticket.checked?
      render :status=>409, :json=>{:message=>t('api.v1.ticket.checked_on', date: l(@ticket.updated_at, :format => :long))}
    elsif !@ticket.paid?
      render :status=>409, :json=>{:message=>t('api.v1.ticket.not_paid')}
    else
      @ticket.update_attribute(:checked, true)
      render(json: { html: render_to_string(partial: "tickets/mobile_ticket")})
    end
  end

end
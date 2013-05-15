class TicketsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :secure_ticket]
  before_filter :get_event, :except => :my_tickets
  # GET /my_tickets
  def my_tickets
    @tickets = Ticket.where("user_id=?",current_user.id)
  end

  # GET /e/:event_id/t/:ticket_id/r/:random_key
  def secure_ticket
    @ticket = Ticket.find_by_id_and_random_key(params[:ticket_id], params[:random_key])
    render 'show'
  end

  # GET /events/:event_id/tickets/:ticket_id/detail
  def detail
    @ticket = Ticket.find(params[:ticket_id])
  end

  # GET /events/:event_id/tickets/1
  def show
    @ticket = Ticket.find(params[:id])
  end

  # GET /events/:event_id/tickets/new
  def new
    @ticket = Ticket.new#(event_id: params[:event_id])
  end

  # POST /events/:event_id/tickets
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.user = current_user

    @ticket.process_image_custom_fields

    if @ticket.save
      if @event.organizer == current_user
        @ticket.update_attribute(:paid, true)
        redirect_to event_ticket_url(@event, @ticket), notice: t('tickets.message.success_create')
      else
        redirect_to @ticket.paypal_url(secure_ticket_url(@event, @ticket, @ticket.random_key), payment_notifications_url)
      end
    else
      render action: "new"
    end
  end

  # PUT /events/:event_id/tickets/1
  def update
    @ticket = Ticket.find(params[:id])
      if @ticket.update_attributes(params[:ticket])
        redirect_to event_ticket_url(@event, @ticket), notice: t('tickets.message.success_update')
      else
        render action: "edit"
      end
  end

  private
  def get_event
    @event = Event.find(params[:event_id])
  end
end

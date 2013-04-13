class TicketsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :secure_ticket]
  before_filter :get_event, :except => :my_tickets
  # GET /my_tickets
  def my_tickets
    @tickets = Ticket.where("user_id=?",current_user.id)
  end

  # GET /ticket/:random_key
  def secure_ticket
    @ticket = Ticket.find_by_id_and_random_key(params[:ticket_id], params[:random_key])
    render 'show'
  end

  # GET /events/:event_id/tickets/1
  def show
    @ticket = Ticket.find(params[:id])
  end

  # GET /events/:event_id/tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /events/:event_id/tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /events/:event_id/tickets
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.event = @event
    @ticket.user = current_user

    if @ticket.save
      if @event.organizer == current_user
        @ticket.paid = true
        @ticket.save
        redirect_to event_ticket_url(@event, @ticket), notice: 'Ticket was successfully created.'
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
        redirect_to event_ticket_url(@event, @ticket), notice: 'Ticket was successfully updated.'
      else
        render action: "edit"
      end
  end

  # DELETE /events/:event_id/tickets/1
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to event_url(@event)
  end

  private
  def get_event
    @event = Event.find(params[:event_id])
  end
end

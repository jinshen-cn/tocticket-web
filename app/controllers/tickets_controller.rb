class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_event, :except => :my_tickets
  # GET /my_tickets
  # GET /my_tickets.json
  def my_tickets
    @tickets = Ticket.where("user_id=?",current_user.id)

    respond_to do |format|
      format.html # my_tickets.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /events/:event_id/tickets/1
  # GET /events/:event_id/tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /events/:event_id/tickets/new
  # GET /events/:event_id/tickets/new.json
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /events/:event_id/tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /events/:event_id/tickets
  # POST /events/:event_id/tickets.json
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
        redirect_to @ticket.paypal_url(event_ticket_url(@event, @ticket), payment_notifications_url)
      end
    else
      render action: "new"
    end
  end

  # PUT /events/:event_id/tickets/1
  # PUT /events/:event_id/tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to event_ticket_url(@event, @ticket), notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/:event_id/tickets/1
  # DELETE /events/:event_id/tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to event_url(@event) }
      format.json { head :no_content }
    end
  end
  private
  def get_event
    @event = Event.find(params[:event_id])
  end
end

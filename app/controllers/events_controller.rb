class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  before_filter :is_event_organizer, :only => [:edit, :update, :destroy]
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.where("organizer_id=?",current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def to_uri
    @event = Event.find_all_by_uri(params[:uri])[0]
    if @event.nil?
      render :file => 'public/404.html'
    else
      render :show
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.paypal_account = current_user.email

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.organizer = current_user

    respond_to do |format|
      if @event.save
        format.html #{ redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  private
  def is_event_organizer
    @event = Event.find(params[:id])
    unless current_user == @event.organizer
      redirect_to @event, alert: 'You have to be the event organizer to edit this event.'
    end
  end
end

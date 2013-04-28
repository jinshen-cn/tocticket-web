class TicketTypesController < ApplicationController
  before_filter :authenticate_user!

  # GET /events/:event_id/ticket_types/new
  def new
    @event = Event.find(params[:event_id])
    render partial: "form", locals: { ticket_type: TicketType.new }
  end

  # GET /events/:event_id/ticket_types/:id/edit
  def edit
    @event = Event.find(params[:event_id])
    render partial: "form", locals: { ticket_type: TicketType.find(params[:id]) }
  end

  # POST /events/:event_id/ticket_types
  def create
    @ticket_type = TicketType.new(params[:ticket_type])
    @ticket_type.event = Event.find(params[:event_id])

    if @ticket_type.save
      redirect_to edit_event_path(@ticket_type.event), notice: t('events.message.success_update')
    end
  end

  # PUT /events/:event_id/ticket_types/:id
  def update
    @ticket_type = TicketType.find(params[:id])
    if @ticket_type.update_attributes(params[:ticket_type])
      redirect_to edit_event_path(@ticket_type.event), notice: t('events.message.success_update')
    end
  end

  # DELETE /events/:event_id/ticket_types/:id
  def destroy
    @ticket_type = TicketType.find(params[:id])
    @ticket_type.destroy if @ticket_type.tickets.empty?
    redirect_to edit_event_path(@ticket_type.event), notice: t('events.message.success_update')
  end
end

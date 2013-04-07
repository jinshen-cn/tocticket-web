class TicketMailer < ActionMailer::Base
  layout 'email'
  default from: "admin@tocticket.com"

  def ticket_email(ticket)
    @ticket = ticket
    @event = ticket.event
    mail(to: ticket.email, subject: "Ticket purchased for the Event: " + ticket.event.name)
  end
end

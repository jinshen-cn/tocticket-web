class TicketMailer < ActionMailer::Base
  layout 'email'
  default from: "admin@tocticket.com"

  def ticket_email(ticket)
    @ticket = ticket
    @event = ticket.event
    mail(to: ticket.email, subject: t("tickets.email.subject", event_name:ticket.event.name))
  end
end

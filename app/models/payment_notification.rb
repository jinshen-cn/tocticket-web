class PaymentNotification < ActiveRecord::Base
  attr_accessible :ticket_id, :params, :status, :transaction_id
  belongs_to :ticket
  serialize :params
  after_create :mark_ticket_as_purchased
  
private
  def mark_ticket_as_purchased
    if status == "Completed"
      ticket.update_attributes(:unpaid => false)
    end
  end
end
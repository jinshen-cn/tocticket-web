module TicketsHelper
  def register_video_print(ticket)
    video_print = VideoPrint.new
    video_print.ticket = ticket
    video_print.save
  end
end

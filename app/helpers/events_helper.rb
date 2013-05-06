module EventsHelper

  def ticket_type_time_series(event)
    event.ticket_types.map do |type|
      "{
          name: '#{ type.name }',
          pointInterval: #{ 1.day * 1000 },
          pointStart: #{ 3.weeks.ago.to_i * 1000 },
          data: #{ (3.weeks.ago.to_date..Date.today).map { |date| type.tickets.total_on(date).to_f}.inspect }
      }"
    end.join(",")
  end

end

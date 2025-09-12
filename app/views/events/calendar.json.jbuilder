json.array!(@event.votes) do |vote|
  json.id vote.id
  json.title "#{vote.name} (#{vote.status})"
  json.start vote.date
  json.allDay true
  json.color case vote.status
             when "ok" then "green"
             when "maybe" then "orange"
             when "no" then "red"
             end
end
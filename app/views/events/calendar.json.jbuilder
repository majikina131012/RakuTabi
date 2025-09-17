json.array!(@events) do |event|
  json.id event.id
  json.title event.title
  json.start event.start_time.in_time_zone('Tokyo')
  json.end event.end_time.in_time_zone('Tokyo')
end
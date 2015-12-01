json.array!(@timetables) do |timetable|
  json.extract! timetable, :id, :date, :slot1, :slot2, :slot3, :slot4, :employee_id
  json.url timetable_url(timetable, format: :json)
end

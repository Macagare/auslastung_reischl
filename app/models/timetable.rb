class Timetable < ActiveRecord::Base
  belongs_to :employee
  scope :find_by_employee_id, ->(employee_id) { where('employee_id = ?', employee_id) }
  scope :date_between, -> (start_date, end_date) { where('date >= ? AND date <= ?', start_date, end_date) }
end

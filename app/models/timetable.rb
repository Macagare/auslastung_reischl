class Timetable < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
  scope :find_by_employee_id, ->(employee_id) { where('employee_id = ?', employee_id) }
end

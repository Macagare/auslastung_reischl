class Timetable < ActiveRecord::Base
  belongs_to :employee, dependent: :destroy
end

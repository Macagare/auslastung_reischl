class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.date :date, default: Date.today
      t.boolean :slot1, default: true
      t.boolean :slot2, default: true
      t.boolean :slot3, default: true
      t.boolean :slot4, default: true
      t.belongs_to :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

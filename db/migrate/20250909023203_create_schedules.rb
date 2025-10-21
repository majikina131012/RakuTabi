class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :event_id
      t.date :date
      t.string :remarks
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end

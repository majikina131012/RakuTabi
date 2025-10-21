class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :group_id
      t.integer :user_id
      t.integer :event_id
      t.integer :status
      t.date :day
      t.string :time
      t.datetime :start_time

      t.timestamps
    end
  end
end

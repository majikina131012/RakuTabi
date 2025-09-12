class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :status
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end

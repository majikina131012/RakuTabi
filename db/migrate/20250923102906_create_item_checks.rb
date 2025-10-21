class CreateItemChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :item_checks do |t|
      t.integer :item_id
      t.integer :user_id
      t.boolean :is_ok, default: false

      t.timestamps
    end
  end
end

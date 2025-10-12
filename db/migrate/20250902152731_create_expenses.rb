class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.integer :group_id
      t.integer :payer_id
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end

class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.integer :user_id
      t.integer :expense_id
      t.float :burden_amount
      t.float :must_pay
      t.float :pay
      t.integer :pay_to_user_id

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :group_id
      t.string :name
      t.string :remarks

      t.timestamps
    end
  end
end

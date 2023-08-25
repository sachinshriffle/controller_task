class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :mobile_number
      t.string :add
      t.references :course , null: false, foreign_key: true

      t.timestamps
    end
  end
end

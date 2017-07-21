class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :amount
      t.references :seller
      t.references :buyer

      t.timestamps
    end
  end
end

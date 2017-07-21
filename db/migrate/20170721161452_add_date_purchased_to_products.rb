class AddDatePurchasedToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :date_purchased, :datetime
  end
end

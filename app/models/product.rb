class Product < ApplicationRecord
  belongs_to :seller,
    class_name: 'User'

  belongs_to :buyer,
             optional: true,
             class_name: 'User'
  validates :name, length:{ minimum: 2 }
  validates :amount, :seller, presence: true
end

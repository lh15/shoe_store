class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, :email, :password, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  has_many :purchased_products,
    foreign_key: 'buyer_id',
    class_name: 'Product'
    
  has_many :products_selling,
    foreign_key: 'seller_id',
    class_name: 'Product'

  has_many :sold_products , -> { where(buyer_id: !nil) },
    foreign_key: 'seller_id',
    class_name: 'Product'
  
end

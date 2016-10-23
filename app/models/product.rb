class Product < ApplicationRecord
  has_many :order_items
  has_many :reviews
  
  belongs_to :merchant

  has_many :categories, through: :categories_products
  has_many :categories_products

  validates :name, presence: :true, uniqueness: :true
  validates :price, presence: :true, numericality: {greater_than: 0}
  validates :merchant_id, presence: :true

  def update_quantity(number)
    number = number.to_i
    if check_availability(number)
      return self.quantity += number
    end
  end

  def check_availability(number)
    self.quantity >= number
  end

end

class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :weight, :width, :height, :depth, :sku, :supplier, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: {is: 20}
  validates :weight, :width, :height, :depth, numericality: { only_integer: true, greater_than: 0}
end
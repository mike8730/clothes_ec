class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 0 }
  validates :gender_id, presence: true, numericality: { other_than: 0 }

  has_many :item_variants
  belongs_to_active_hash :category
  belongs_to_active_hash :gender
end

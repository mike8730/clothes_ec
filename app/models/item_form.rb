class ItemForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :name, :price, :description, :category_id, :gender_id, :variants_attributes

  validates :name, :price, :description, :category_id, :gender_id, presence: true
  validate :variants_presence

  def variants_attributes=(attributes)
    @variants = attributes.map do |_, variant_params|
      VariantForm.new(variant_params)
    end
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      item = Item.create!(
        name: name,
        price: price,
        description: description,
        category_id: category_id,
        gender_id: gender_id
      )

      @variants.each do |variant_form|
        item.item_variants.create!(variant_form.attributes)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def variants_presence
    errors.add(:base, "SKUを１つ以上入力してください") if @variants.blank?
  end
end

class VariantForm
  include ActiveModel::Model

  attr_accessor :size_id, :color_id, :stock_quantity, :price
  validates :size_id, :color_id, :stock_quantity, :price, presence: true

  def attributes
    {
      size_id: size_id,
      color_id: color_id,
      stock_quantity: stock_quantity,
      price: price
    }
  end
end
